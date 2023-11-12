require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#find_or_create_from_auth_hash!" do

    let(:auth_hash) do
      {
        provider: "test_provider",
        uid: "123456",
        info: {
          nickname: "yo",
          image: "http://example.com/image.com"
        }
      }
    end

    context "既存ユーザーが存在する場合" do
      before do
        user.reload
      end
      let(:user) { FactoryBot.create(:user, provider: auth_hash[:provider], uid: auth_hash[:uid], image_url: auth_hash[:info][:image]) }

      it "既存ユーザーを返却すること" do
        expect(User.find_or_create_from_auth_hash!(auth_hash)).to eq user
      end
    end

    context "既存ユーザーが存在しない場合" do

      it "auth_hashの内容で新しいユーザーが作成されていること" do
        new_user = User.find_or_create_from_auth_hash!(auth_hash)
        expect(new_user.provider).to eq auth_hash[:provider]
        expect(new_user.uid).to eq auth_hash[:uid]
        expect(new_user.name).to eq auth_hash[:info][:nickname]
        expect(new_user.image_url).to eq auth_hash[:info][:image]
      end
    end
  end
end
