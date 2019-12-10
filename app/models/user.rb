class User < ApplicationRecord
  # TODO: Using localization instead
  SLEEPING_MSG = "You are sleeping"
  AWAKE_MSG = "You are awake"
  ERROR_MSG = "Something went wrong"

  has_many :tracking_sleeps, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  enum status: [:awake, :sleeping]
  validates_presence_of :name


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

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
