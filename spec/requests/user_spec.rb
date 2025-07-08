# spec/requests/api/v1/users_spec.rb
require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let!(:users) { create_list(:user, 3) }
  let(:user_id) { users.first.id }

  describe "GET /api/v1/users" do
    it "returns users" do
      get "/api/v1/users"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /api/v1/users/:id" do
    it "returns the user" do
      get "/api/v1/users/#{user_id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(user_id)
    end
  end

  describe "POST /api/v1/users" do
    let(:valid_params) { { user: { name: "New User", email: "newuser@example.com", phone: "081123123" } } }

    it "creates a new user" do
      expect {
        post "/api/v1/users", params: valid_params
      }.to change(User, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT /api/v1/users/:id" do
    let(:update_params) { { user: { name: "Updated Name" } } }

    it "updates the user" do
      put "/api/v1/users/#{user_id}", params: update_params
      expect(response).to have_http_status(:ok)
      expect(User.find(user_id).name).to eq("Updated Name")
    end
  end

  describe "DELETE /api/v1/users/:id" do
    it "deletes the user" do
      expect {
        delete "/api/v1/users/#{user_id}"
      }.to change(User, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
