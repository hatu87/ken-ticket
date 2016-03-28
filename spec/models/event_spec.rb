require 'rails_helper'

RSpec.describe Event, type: :model do

  describe '.upcoming' do
    it 'should be empty if there are no event' do
      expect(Event.upcomming).to eq([])
    end

    it 'should only show upcomming events if there are many events' do
      venue = FactoryGirl.create(:venue)
      category = FactoryGirl.create(:category)

      FactoryGirl.create(:event, name: 'event 1', starts_at: DateTime.now - 1,
                         venue: venue,
                         category: category)

      event = FactoryGirl.create(:event, name: 'event 2', starts_at: DateTime.now + 1,
                                 venue: venue,
                                 category: category)

      expect(Event.upcomming).to eq([event])
    end
  end
  describe '.search' do
    it 'shound be an array of only upcomming events' do
      venue = FactoryGirl.create(:venue)
      category = FactoryGirl.create(:category)

      FactoryGirl.create(:event, name: 'việt nam thử thách 123', starts_at: DateTime.now - 1,
                                  venue: venue,
                                  category: category)

      event = FactoryGirl.create(:event, name: 'việt nam thử thách', starts_at: DateTime.now + 1,
                                  venue: venue,
                                  category: category)

      expect(Event.search('việt nam')).to eq([event])
    end

    it 'should be an empty array if there are no events belongs to search condition' do
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

      expect(Event.search('abc')).to eq([])
    end

    it 'should be an array of events belongs to the search condition' do
      venue = FactoryGirl.create(:venue)
      category = FactoryGirl.create(:category)
      FactoryGirl.create(:event, name: 'thử thách', starts_at: DateTime.now + 1,
                         venue: venue,
                         category: category)

      event = FactoryGirl.create(:event, name: 'việt nam thử thách', starts_at: DateTime.now + 1,
                                  venue: venue,
                                  category: category)

      expect(Event.search('việt nam')).to eq([event])
    end

    it 'should be an array of uncase-sensitive events belongs to the search condition' do
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
      # binding.pry
      expect(Event.search('việt nam')).to eq([event1, event2])
    end
  end

  describe 'validation' do
    context 'presence' do
      it "is invalid without starts at" do
        event = FactoryGirl.build(:event, starts_at: nil)
        event.valid?

        expect(event.errors[:starts_at]).to include("can't be blank")
      end
    end
  end
end
