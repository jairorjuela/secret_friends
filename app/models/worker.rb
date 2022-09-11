class Worker < ApplicationRecord
  include StringValidations
  include CommonValidates

  belongs_to :location
  has_many :games

  validates :name, presence: true, length: { in: 4..30 }
  validates :name, format: { with: proc { |w| w.regex_valid_name }, multiline: true }, if: :will_save_change_to_name?
  validates :name, format: { without: proc { |w| w.regex_insecure_string } }, if: :will_save_change_to_name?

  before_create :assign_year

  scope :order_by_name, -> { order('workers.name') }

  def couple_games
    games.map(&:couple_number)
  end

  def played_games
    games.map(&:year_game).map(&:to_i)
  end

  def assign_year
    self.year_game = Date.current.year
  end
end
