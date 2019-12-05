class User < ApplicationRecord
  has_many :tracking_sleeps, dependent: :destroy

  validates_presence_of :name
end
