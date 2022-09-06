class Game < ApplicationRecord
  include StringValidations

  belongs_to :worker

  validates :year_game, presence: true, length: { is: 4 }
  validate :valid_year?

  validate :worker_has_game_in_this_year?

  before_save :assign_number

  scope :order_by_year_game, -> { order('games.year_game') }

  def worker_has_game_in_this_year?
    workers = Worker.where(year_game: year_game)

    return if workers.blank?

    games = workers.find(worker_id).games

    return if games.blank?

    return unless games.where(worker_id: worker_id).map(&:year_game).include?(year_game)

    self.errors.add(:worker, :year_taken)
  end

  def assign_number
    (1...100000).to_a.sort.each do |number|
      self.couple_number = number

      break unless self.class.where(couple_number: self.couple_number).size >= 2
    end
  end

  def valid_year?
    return if (2022...2032).to_a.include?(year_game.to_i)

    self.errors.add(:year_game, :invalid_date)
  end
end
