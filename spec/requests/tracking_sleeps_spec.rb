require 'rails_helper'

RSpec.describe 'TrackingSleep API', type: :request do
  let!(:user) {create(:user)}
  let!(:tracking_sleeps){create_list(:tracking_sleep, 5, user_id: user.id)}
  let(:user_id){user.id}

  describe "GET /api/v1/users/:user_id/tracking_sleeps" do
    before {get "/api/v1/users/#{user_id}/tracking_sleeps" }

    context "when user does not exist" do
      let!(:user_id) {0}

      it "should return response 404" do
        expect(response).to have_http_status(404)
      end
    end

    context "when user exists" do
      context "when tracking_sleep exist" do
        it "should return tracking_sleep of user" do
          expect(body_json.size).to eq 5
        end
      end

      context "when tracking_sleep does not exist" do
        let!(:other_user) {create(:user)}
        let(:user_id){other_user.id}
        it "should return empty json" do
          expect(body_json).to be_empty
        end
      end
    end
  end

end
