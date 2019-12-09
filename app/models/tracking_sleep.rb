class TrackingSleep < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id, :start_time
  validate :end_time_greater_than_start_time
  # validate :new_sleep

  before_save :update_period_attr

  def end_time_greater_than_start_time
    return if start_time.blank? || end_time.blank?
    if start_time > end_time
      errors.add(:end_time, "must be greater than start_time")
    end
  end

  def update_period_attr
    self.period = ((end_time - start_time) / 3600).round(3) if end_time
  end

  def validate_new_sleep

  end
end
