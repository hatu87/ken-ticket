require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET index" do
    it "render the index template" do
      get :index

      expect(response).to render_template("index")
    end

    it "should return an empty array if there are no events" do
      get :index

      expect(assigns[:events]).to eq([])
    end

    it "should return an array of upcomming events if there are many events" do
      venue = FactoryGirl.create(:venue)
      category = FactoryGirl.create(:category)

      FactoryGirl.create(:event, name: 'event 1', starts_at: DateTime.now - 1,
                         venue: venue,
                         category: category)

      event = FactoryGirl.create(:event, name: 'event 2', starts_at: DateTime.now + 1,
                                 venue: venue,
                                 category: category)

      get :index

      expect(assigns[:events]).to eq([event])
    end

    it "should return an array of searched upcomming events if there are search conditions" do
      venue = FactoryGirl.create(:venue)
      category = FactoryGirl.create(:category)

      FactoryGirl.create(:event, name: 'event abc', starts_at: DateTime.now - 1,
                         venue: venue,
                         category: category)

      FactoryGirl.create(:event, name: 'event 123', starts_at: DateTime.now + 1,
                                 venue: venue,
                                 category: category)

      event = FactoryGirl.create(:event, name: 'event def', starts_at: DateTime.now + 1,
                                 venue: venue,
                                 category: category)

      get :index, {:search => 'de'}

      expect(assigns[:events]).to eq([event])

    end

    it "should return an array of uncase-sensitive searched upcomming events if there are search conditions" do
      venue = FactoryGirl.create(:venue)
      category = FactoryGirl.create(:category)

      FactoryGirl.create(:event, name: 'thử thách', starts_at: DateTime.now + 1,
                         venue: venue,
                         category: category)

      event1 = FactoryGirl.create(:event, name: 'Việt Nam thử thách', starts_at: DateTime.now + 1,
                         venue: venue,
                         category: category)

      event2 = FactoryGirl.create(:event, name: 'việt nam thử thách', starts_at: DateTime.now + 1,
                                 venue: venue,
                                 category: category)

      get :index, {:search => 'việt nam'}

      expect(assigns[:events]).to eq([event1, event2])

    end
  end
end
