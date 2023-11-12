FactoryBot.define do
  factory :user, aliases: [:owner] do
    provider { "github" }
    uid { "testUid" }
    sequence(:name) { |i| "name#{i}" }
    sequence(:image_url) { |i| "http://example.com/image#{i}.jpg"}
  end
end
