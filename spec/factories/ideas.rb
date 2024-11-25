# frozen_string_literal: true

# Model for storing ideas created by users.
FactoryBot.define do
  factory :idea do
    title { 'Sample Idea' }
    description { 'Sample description' }
    association :user
  end
end
