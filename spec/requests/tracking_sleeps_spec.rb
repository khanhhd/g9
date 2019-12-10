require 'rails_helper'

RSpec.describe 'TrackingSleep API', type: :request do
  let!(:user) {create(:user)}
  let!(:tracking_sleeps){create_list(:tracking_sleep, 5, user_id: user.id)}
  let(:user_id){user.id}

  describe "GET /api/v1/users/:user_id/tracking_sleeps" do
    let(:params){{}}
    before {get "/api/v1/users/#{user_id}/tracking_sleeps", params: params}

    context "when user does not exist" do
      let!(:user_id) {0}

      it "should return response 404" do
        expect(response).to have_http_status(404)
      end
    end

    context "when params is not valid" do
      it "should return empty" do
        expect(body_json).to be_empty
      end
    end
    context "when params is valid" do
      let(:params){{filter: "me"}}
      it "should return all current user's sleep activities" do
        expect(body_json.size).to eq 5
      end
    end

    context "when user does not have friend" do
      let(:params){{filter: "friend", friend_id: 2}}
      it "should return empty array" do
        expect(body_json).to be_empty
      end
    end

    context "when user does have friend" do
      let(:friend) {create(:user)}
      let(:params){{filter: "friend", friend_id: friend.id}}
      before do
        user.follow friend
        20.times.each do
          friend.sleeping? ? friend.wakeup : friend.sleep
        end
        get "/api/v1/users/#{user_id}/tracking_sleeps", params: params
      end
      it "should return friend's sleep activities from last week" do
        expect(body_json.size).to eq 10
      end
    end
  end

end
