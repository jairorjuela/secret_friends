class Location < ApplicationRecord
  include StringValidations

  has_one :worker

  validates :name, presence: true, length: { in: 3..30 }
  validates :name, format: { with: proc { |w| w.regex_valid_name }, multiline: true }, if: :will_save_change_to_name?
  validates :name, format: { without: proc { |w| w.regex_insecure_string } }, if: :will_save_change_to_name?

  scope :order_by_name, -> { order('locations.name') }
end
