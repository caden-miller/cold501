FactoryBot.define do
    factory :idea do
      title { 'Sample Idea' }
      description { 'Sample description' }
      association :user
    end
  end
  