require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:events) { create_list(:event, 3, owner: user, start_at: Time.now + 1.days, end_at: Time.now + 1.days + 1.hours) }
    subject(:request) { get root_path }

    it "ステータスコードが200となること" do
      subject
      expect(response).to have_http_status(200)
    end

    it "すべてのeventリソースが取得できていること" do
      subject
      expect(assigns(:events)).to match_array(events)
    end
  end
end
