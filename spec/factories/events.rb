FactoryBot.define do
  factory :event do
    association :owner
    name { "test event" }
    place { "test place" }
    start_at { Time.now }
    end_at { Time.now }
    content { "test content" }
  end
end
