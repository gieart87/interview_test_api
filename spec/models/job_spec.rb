# spec/models/job_spec.rb
require 'rails_helper'

RSpec.describe Job, type: :model do
  it "is valid with valid attributes" do
    job = build(:job)
    expect(job).to be_valid
  end

  it "is invalid without a title" do
    job = build(:job, title: nil)
    expect(job).to_not be_valid
  end

  it "must belong to a user" do
    job = build(:job, user: nil)
    expect(job).to_not be_valid
  end
end
