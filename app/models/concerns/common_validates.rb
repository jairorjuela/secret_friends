module CommonValidates
  extend ActiveSupport::Concern

  def read_only?
    return if new_record?

    self.errors.add(:read_only?, :game_changed)
  end
end
