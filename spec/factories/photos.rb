# frozen_string_literal: true

FactoryBot.define do
  factory :photo do
    link { 'MyString' }
    title { 'MyString' }
    description { 'MyText' }
    created_by { nil }
  end
end
