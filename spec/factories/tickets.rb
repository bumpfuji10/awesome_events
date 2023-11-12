FactoryBot.define do
  factory :ticket do
    association :user
    comment { "test comment" }
  end
end
