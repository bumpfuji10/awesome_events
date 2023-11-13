require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "GET #show" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event, name: "すてきなイベント", owner: user) }
    subject(:request) { get "/events/#{event.id}" }

    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:provider]
      get '/auth/test_provider/callback'
    end

    it "ステータスコードが200であること" do
      subject
      expect(response).to have_http_status(200)
    end

    it "event内容が取得できること" do
      subject
      expect(response.body).to include(event.name)
    end
  end

  describe "GET #new" do

    context "認証されたユーザーの場合" do
      before do
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:provider]
        get '/auth/test_provider/callback'
        get "/events/new"
      end

      it "ステータスコードが200であること" do
        get "/events/new"
        expect(response).to have_http_status(200)
      end
    end

    context "未認証の場合" do

      it "root_pathにリダイレクトされること" do
        get "/events/new"
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:provider]
      get '/auth/test_provider/callback'
      get "/events/new"
    end

    context '適切なパラメータが渡された場合' do

      it '新しいeventが作成できること' do
        expect {
          post "/events", params: { event: { name: "素敵イベント", place: "公民館", password: "foo", content: "素敵なイベント乞うご期待", start_at: Time.now + 1.days, end_at: Time.now + 1.days + 1.hours } }
        }.to change(Event, :count).by(1)
      end
    end
  end
end
