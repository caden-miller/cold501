# frozen_string_literal: true

# Model for storing merchandise items.
FactoryBot.define do
  factory :merchandise do
    title { 'Test Merchandise' }
    description { 'A description for test merchandise' }
    link { 'https://tamu.estore.flywire.com/sample-link' }
  end
end
