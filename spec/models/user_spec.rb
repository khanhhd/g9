require 'rails_helper'

RSpec.describe User, type: :model do
  it {should have_many(:tracking_sleeps).dependent(:destroy)}
  it {should validate_presence_of(:name)}
end
