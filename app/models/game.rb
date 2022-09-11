class Game < ApplicationRecord
  include StringValidations
  include CommonValidates

  belongs_to :worker

  validates :year_game, presence: true, length: { is: 4 }

  validate :valid_year?
  validate :worker_has_game_in_this_year?
  validate :read_only?, on: :update

  before_validation :assign_number
  after_commit :assign_worker_year
  before_create :valid_couple?

  scope :order_by_year_game, -> { order('games.year_game') }

  def worker_has_game_in_this_year?
    workers_ids = Game.where(year_game: year_game).map(&:worker).map(&:id)

    return if workers_ids.blank?

    return unless workers_ids.include?(worker.id)

    self.errors.add(:worker, :year_taken)
  end

  def assign_number
    (1...100000).to_a.sort.each do |number|
      self.couple_number = number

      break unless self.class.where(couple_number: self.couple_number).size >= 2
    end
  end

  def assign_worker_year
    parse_years = worker.year_game.split(' / ').uniq
    add_years = (parse_years << year_game).uniq

    worker.update_column(:year_game, add_years.join(' / '))
  end

  def valid_year?
    return if (2022...2032).to_a.include?(year_game.to_i)

    self.errors.add(:year_game, :invalid_date)
  end

  def valid_couple?
    return if year_game.eql?('2022')

    return if worker.games.blank?

    possible_match = Game.where(couple_number: couple_number).last&.worker

    return if possible_match.nil?

    same_years = possible_match.games.each_with_object([]).each do |game, array|
      worker_couple_numbers = worker.games.map(&:couple_number)
      include_couple = worker_couple_numbers.include?(game.couple_number)

      array << game.year_game if include_couple
    end

    return if same_years.blank?

    last_year = same_years.max.to_i
    count_years = year_game.to_i - last_year

    return if count_years > 2

    self.errors.add(:year_game, :same_couple)
    throw(:abort)
  end
end
