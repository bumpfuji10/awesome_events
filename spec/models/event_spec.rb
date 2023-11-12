require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "validates" do
    context "name" do
      let(:user) { FactoryBot.create(:user) }
      let(:invalid_event) { FactoryBot.build(:event, name: "a" * 51, owner: user) }

      it "nameが51文字以上の場合、eventが作成できないこと" do
        expect(invalid_event).to be_invalid
      end
    end
  end
end
