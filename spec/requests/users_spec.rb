require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:users) {create_list(:user, 5)}
  let(:user_id) {users.first.id}

  describe 'GET /api/v1/users/:id' do
    before {get "/api/v1/users/#{user_id}"}

    context "when user exists" do
      it "return status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns an user record" do
        expect(body_json).not_to be_empty
        expect(body_json["id"]).to eq user_id
      end
    end

    context "when user does not exists" do
      let(:user_id){-1}
      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "PUT /api/v1/users/:id" do
    let(:params) {{id: 0}}
    before {put "/api/v1/users/#{params[:id]}", params: params}

    context "when params is empty" do
      it "should response stautus code 404" do
        expect(response).to have_http_status(404)
      end
    end

    context "when user_action params is not valid" do
      let(:params) {{id: 1, user_action: "test"}}
      it "should response error message" do
        expect(body_json["message"]).to eq UserService::INVALID_ACTION_MSG
      end
    end

    context "when user_action is wakeup" do
      let(:params) {{id: 1, user_action: "wakeup"}}
      let(:user){users.first}
      before do
        user.sleep
        put "/api/v1/users/#{params[:id]}", params: params
      end

      it "should response wakeup message" do
        expect(body_json["message"]).to eq User::AWAKE_MSG
      end

      it "should change status from sleeping to awake" do
        expect(user.reload.awake?).to be_truthy
      end
    end

    context "when user_action is sleep" do
      let(:user){users.last}
      let(:params) {{id: user.id, user_action: "sleep"}}

      it "should response wakeup message" do
        expect(body_json["message"]).to eq User::SLEEPING_MSG
      end

      it "should change status from sleeping to awake" do
        expect(user.reload.sleeping?).to be_truthy
      end
    end
  end
end
