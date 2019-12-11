require 'rails_helper'

RSpec.describe 'Relationship API', type: :request do
  let!(:users) {create_list(:user, 5)}
  let(:user) {users.first}
  let(:user_id) {user.id}
  let(:friend) {users.last}

  describe "POST /api/v1/users/:user_id/relationships" do
    let(:params) {{follower_id: user_id, followed_id: friend.id}}

    context "when data is valid" do
      before {post "/api/v1/users/#{user_id}/relationships", params: params}
      it "follows other user" do
        expect(body_json["message"]).to eq RelationshipService::FOLLOWED_MSG
      end
      it "should have status 200" do
        expect(response).to have_http_status(200)
      end

    end

    context "when they have already been friend" do
      let!(:other_friend){create(:user)}
      let!(:new_user){create(:user)}
      let(:params) {{follower_id: new_user.id, followed_id: other_friend.id}}

      before do
        new_user.follow(other_friend)
        post "/api/v1/users/#{new_user.id}/relationships", params: params
      end

      it "should have status 400" do
        expect(response).to have_http_status(400)
      end

      it "responses error message" do
        expect(body_json["message"]).to eq RelationshipService::CANNOT_FOLLOW_MSG
      end
    end

  end

  describe "DELETE /api/v1/users/:user_id/relationships" do
    let!(:peter){create(:user)}
    let!(:mary){create(:user)}
    let(:params) {{follower_id: peter.id, followed_id: mary.id}}

    context "when they are not followed to each other yet" do
      before do
        delete "/api/v1/users/#{peter.id}/relationships", params: params
      end

      it "should response status code 400" do
        expect(response).to have_http_status(400)
      end

      it "should reponses error message" do
        expect(body_json["message"]).to eq RelationshipService::CANNOT_UNFOLLOW_MSG
      end
    end

    context "when data is valid" do
      before do
        peter.follow(mary)
        delete "/api/v1/users/#{peter.id}/relationships", params: params
      end
      it "follows other user" do
        expect(body_json["message"]).to eq RelationshipService::UNFOLLOWED_MSG
      end
    end
  end
end
