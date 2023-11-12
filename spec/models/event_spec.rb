
require 'rails_helper'
RSpec.describe Event, type: :model do

  describe "validates" do
    let(:user) { FactoryBot.create(:user) }

    context "name" do

      context "nameが50文字以内の場合" do
      let(:valid_event) { FactoryBot.build(:event, name: "a" * 50, owner: user) }

        it "eventが有効であること" do
          expect(valid_event).to be_valid
        end
      end
    end

    context "nameが51文字以上の場合" do
      let(:invalid_event) { FactoryBot.build(:event, name: "a" * 51, owner: user) }

      it "eventが無効であること" do
        expect(invalid_event).to be_invalid
      end
    end

    context "nameが入力されている場合" do
      let(:valid_event) { FactoryBot.build(:event, name: "test event", owner: user) }

      it "eventが有効であること" do
        expect(valid_event).to be_valid
      end
    end

    context "nameが未入力の場合" do
      let(:invalid_event) { FactoryBot.build(:event, owner: user) }
      before do
        invalid_event.name = nil
      end

      it "eventが無効であること" do
        expect(invalid_event).to be_invalid
      end
    end

    context "place" do

      context "placeが100文字以内の場合" do
        let(:valid_event) { FactoryBot.build(:event, place: "a" * 100, owner: user) }

        it "eventが有効であること" do
          expect(valid_event).to be_valid
        end
      end

      context "placeが101文字以上の場合" do
        let(:invalid_event) { FactoryBot.build(:event, place: "a" * 101, owner: user) }

        it "eventが無効であること" do
          expect(invalid_event).to be_invalid
        end
      end

      context "placeが入力されている場合" do
        let(:valid_event) { FactoryBot.build(:event, place: "test place", owner: user) }

        it "eventが有効であること" do
          expect(valid_event).to be_valid
        end
      end

      context "placeが未入力の場合" do

        let(:invalid_event) { FactoryBot.build(:event, owner: user) }
        before do
          invalid_event.place = nil
        end

        it "eventが無効であること" do
          expect(invalid_event).to be_invalid
        end
      end

      context "content" do

        context "contentが2000文字以内の場合" do
          let(:valid_event) { FactoryBot.build(:event, content: "a" * 2000, owner: user) }

          it "eventが有効であること" do
            expect(valid_event).to be_valid
          end
        end

        context "contentが2001文字以上の場合" do
          let(:invalid_event) { FactoryBot.build(:event, content: "a" * 2001, owner: user) }

          it "eventが無効であること" do
            expect(invalid_event).to be_invalid
          end
        end

        context "contentが入力されている場合" do
          let(:valid_event) { FactoryBot.build(:event, content: "test content", owner: user) }

          it "eventが有効であること" do
            expect(valid_event).to be_valid
          end
        end

        context "contentが未入力の場合" do
          let(:invalid_event) { FactoryBot.build(:event, owner: user) }
          before do
            invalid_event.content = nil
          end

          it "eventが無効であること" do
            expect(invalid_event).to be_invalid
          end
        end
      end

      context "start_at" do
        context "start_atが入力されている場合" do
          let(:valid_event) { FactoryBot.build(:event, start_at: Time.now) }

          it "eventが有効であること" do
            expect(valid_event).to be_valid
          end
        end

        context "start_atが未入力の場合" do
          let(:invalid_event) { FactoryBot.build(:event, owner: user) }
          before do
            invalid_event.start_at = nil
          end

          it "eventが無効であること" do
            expect(invalid_event).to be_invalid
          end
        end
      end

      context "end_at" do
        context "end_atが入力されている場合" do
          let(:valid_event) { FactoryBot.build(:event, start_at: Time.now, end_at: Time.now + 1.hours) }

          it "eventが有効であること" do
            expect(valid_event).to be_valid
          end
        end

        context "end_atが未入力の場合" do
          let(:invalid_event) { FactoryBot.build(:event, owner: user) }
          before do
            invalid_event.end_at = nil
          end

          it "eventが無効であること" do
            expect(invalid_event).to be_invalid
          end
        end
      end

      context "start_at_should_be_before_end_at" do

        context "start_atがend_atよりも前の時間の場合" do
          let(:valid_event) { FactoryBot.build(:event, start_at: Time.now, end_at: Time.now + 1.hours, owner: user) }

          it "eventが有効であること" do
            expect(valid_event).to be_valid
          end
        end

        context "start_atがend_atよりも後の時間の場合" do
          let(:invalid_event) { FactoryBot.build(:event, start_at: Time.now, end_at: Time.now - 1.hours, owner: user)}

          it "eventが無効であること" do
            expect(invalid_event).to be_invalid
          end
        end
      end
    end
  end

  describe "#created_by?" do
    let(:event_creator) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user, name: "other_user") }
    let!(:event) { FactoryBot.create(:event, owner: event_creator) }

    context "event_creatorがeventの作成者の場合" do

      it "trueが返却されること" do
        expect(event.created_by?(event_creator)).to eq true
      end
    end

    context "other_userがeventの作成者ではない場合" do

      it "falseが返却されること" do
        expect(event.created_by?(other_user)).to eq false
      end
    end
  end
end
