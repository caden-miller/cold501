# spec/factories/ideas.rb
FactoryBot.define do
    factory :idea do
      title { 'Sample Idea' }
      association :user, factory: :user, strategy: :build # Uses the User factory to create an associated user
    end
  end
  