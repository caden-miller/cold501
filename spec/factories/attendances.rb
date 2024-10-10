FactoryBot.define do
  factory :attendance do
    event { nil }
    user { nil }
    present { false }
    passcode { "MyString" }
    checked_in_at { "2024-09-18 11:31:49" }
  end
end
