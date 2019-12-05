class TrackingSleep < ApplicationRecord
  belongs_to :user
  
  validates_presence_of :user_id, :start_time
end
