require 'rails_helper'

RSpec.describe TrackingSleep, type: :model do
  it {should belong_to(:user)}
  it {should validate_presence_of(:start_time)}
  it {should validate_presence_of(:user_id)}
end
