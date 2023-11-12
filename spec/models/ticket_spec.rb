require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe "validates" do
    let(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event, owner: user) }

    context "comment" do

      context "commentが30文字以内の場合" do
        let(:valid_ticket) { FactoryBot.build(:ticket, user: user, event: event, comment: "a" * 30) }

        it "ticketが有効であること" do
          expect(valid_ticket).to be_valid
        end
      end

      context "commentが31文字以上の場合" do
        let(:invalid_ticket) { FactoryBot.build(:ticket, user: user, event: event, comment: "a" * 31) }

        it "ticketが無効であること" do
          expect(invalid_ticket).to be_invalid
        end
      end

      context "commentが空白の場合" do
        let(:valid_ticket) { FactoryBot.build(:ticket, user: user, event: event, comment: nil) }

        it "commentが空白でも有効であること" do
          expect(valid_ticket).to be_valid
        end
      end
    end
  end
end
