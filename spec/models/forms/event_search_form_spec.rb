require "rails_helper"

RSpec.describe EventSearchForm, type: :model do
  describe "#search" do
    let!(:event_creator) { FactoryBot.create(:user) }
    let!(:event_A) { FactoryBot.create(:event, owner: event_creator, name: "good event") }
    let!(:event_B) { FactoryBot.create(:event, owner: event_creator, name: "bad event") }
    let!(:event_C) { FactoryBot.create(:event, owner: event_creator, name: "ng event") }

    let!(:called_event) { [event_A] }

      it "イベントの呼び出しに成功すること" do
        Event.reindex
        Event.search_index.refresh

        form = EventSearchForm.new(keyword: "good event")
        expect(Event).to receive(:search).with('good event', anything).and_return(called_event)

        result = form.search
        expect(result).to match_array(called_event)

      end

    context "特定のキーワードで検索検索する場合" do
      let!(:upcoming_event) { FactoryBot.create(:event, owner: event_creator, name: "upcoming event", start_at: Time.now + 4.days, end_at: Time.now + 5.days) }
      let!(:past_event) { FactoryBot.create(:event, owner: event_creator, name: "past_event", start_at: Time.now - 1.days) }
      before do
        Event.reindex
        Event.search_index.refresh
      end

      it "指定したキーワードが含まれるイベントが検索結果に含まれること" do
        form = EventSearchForm.new(keyword: "upcoming", start_at: Time.now, page: nil)
        results = form.search.results
        expect(results).to include(upcoming_event)
      end

      context "日付範囲を指定して検索する場合" do
        it "指定された日付範囲を持つイベントのみを返却すること" do
          form = EventSearchForm.new(keyword: "", start_at: Time.now, page: nil)
          results = form.search.results
        end
      end
    end
  end
end
