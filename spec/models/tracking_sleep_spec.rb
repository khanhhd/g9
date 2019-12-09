require 'rails_helper'

RSpec.describe TrackingSleep, type: :model do
  it {should belong_to(:user)}
  it {should validate_presence_of(:start_time)}
  it {should validate_presence_of(:user_id)}

  describe "#update_period_attr" do
    let!(:user) {create(:user)}
    let(:sleep) do
      build(:tracking_sleep, user_id: user.id,
        start_time: 1.hour.ago, end_time: nil)
    end

    before {sleep.save}
    context "when end_time does not present" do
      it "should persist data" do
        expect(sleep.persisted?).to be_truthy
      end
      it "should not update period" do
        expect(sleep.period).to be_nil
      end
    end

    context "when end_time present" do
      let(:sleep) do
        build(:tracking_sleep, user_id: user.id,
          start_time: 3.hour.ago, end_time: 1.hour.ago)
      end
      it "updates period attributes" do
        expect(sleep.period).to eq 2.0
      end
    end
  end
end
