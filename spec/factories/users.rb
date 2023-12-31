FactoryBot.define do
  factory :user, aliases: [:owner] do
    provider { "github" }
    sequence(:uid) { |i| "testUid#{i}" }
    sequence(:name) { |i| "name#{i}" }
    sequence(:image_url) { |i| "http://example.com/image#{i}.jpg"}
  end
end
