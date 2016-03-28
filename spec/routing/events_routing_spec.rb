require "rails_helper"

RSpec.describe "routes for Events", :type => :routing do
  it "routes /events to the index action" do
    expect(get("/events")).to route_to("events#index")
  end

  it 'routes /events/:id to the show action' do
    expect(get("/events/1")).to route_to('events#show', id: "1")
  end
end
