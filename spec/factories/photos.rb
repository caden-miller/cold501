# frozen_string_literal: true

FactoryBot.define do
  factory :photo do
    title { 'Sample Photo' }
    description { 'This is a sample photo.' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample.jpg'), 'image/jpeg') }
    association :user
  end
end
