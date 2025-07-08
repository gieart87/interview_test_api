# spec/factories/jobs.rb
FactoryBot.define do
  factory :job do
    title { "Software Engineer" }
    description { "Responsible for developing and maintaining software applications." }
    status { "pending" }
    association :user   
  end
end
