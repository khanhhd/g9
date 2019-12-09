class User < ApplicationRecord
  SLEEPING_MSG = "You are sleeping"
  AWAKE_MSG = "You are awake"
  ERROR_MSG = "Something went wrong"

  enum status: [:awake, :sleeping]
  validates_presence_of :name
  has_many :tracking_sleeps, dependent: :destroy

  def sleep
    return SLEEPING_MSG if self.sleeping? && self.tracking_sleeps.exists?
    ActiveRecord::Base.transaction do
      self.tracking_sleeps.create!(start_time: Time.current)
      self.sleeping!
      SLEEPING_MSG
    end
  rescue => e
    ERROR_MSG
  end

  def wakeup
    return AWAKE_MSG if self.awake?
    ActiveRecord::Base.transaction do
      tracking = self.tracking_sleeps.last
      tracking.update! end_time: Time.current
      self.awake!
      AWAKE_MSG
    end
  rescue => e
    puts e.message
    ERROR_MSG
  end
end
