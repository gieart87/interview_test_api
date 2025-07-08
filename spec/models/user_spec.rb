# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = build(:user, name: nil)
    expect(user).to_not be_valid
  end

  it "can have many jobs" do
    user = create(:user)
    create_list(:job, 3, user: user)
    expect(user.jobs.count).to eq(3)
  end

  it "deletes associated jobs when user is deleted" do
    user = create(:user)
    create(:job, user: user)
    expect { user.destroy }.to change { Job.count }.by(-1)
  end
end
