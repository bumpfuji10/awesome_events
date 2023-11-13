OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:provider] = OmniAuth::AuthHash.new(
  provider: 'github',
  uid: "123456",
  info: {
    nickname: "yo",
    image: "http://example.com/image"
  }
)
