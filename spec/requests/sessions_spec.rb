require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    context 'with valid credentials' do
      before do
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:provider]
        get '/auth/test_provider/callback'
      end

      it 'userがログインされたこと' do
        expect(session[:user_id]).not_to be_nil
      end

      it 'ホーム画面にリダイレクトされたこと' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
