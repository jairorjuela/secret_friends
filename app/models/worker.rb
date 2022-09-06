class Worker < ApplicationRecord
  include StringValidations

  belongs_to :location

  validates :name, :year_game, presence: true, length: { in: 4..30 }
  validates :name, format: { with: proc { |w| w.regex_valid_name }, multiline: true }, if: :will_save_change_to_name?
  validates :name, format: { without: proc { |w| w.regex_insecure_string } }, if: :will_save_change_to_name?

  validate :valid_year?, on: :create

  scope :order_by_name, -> { order('workers.name') }

  def valid_year?
    return if (2022...2032).to_a.include?(year_game.to_i)

    self.errors.add(:year_game, :invalid_date)
  end
end
