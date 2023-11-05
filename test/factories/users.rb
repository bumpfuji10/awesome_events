FactoryBot.define do
  factory :user, alias: [:owner] do
    provider { "github" }
    sequence(:uid) { |i| "uid#{i}"}
    sequence(:name) { |i| "name#{i}"}
    sequence(:image_url) { |i| "http://example.com/image#{i}.jpg" }
  end
end
