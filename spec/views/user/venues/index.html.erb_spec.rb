require 'rails_helper'

RSpec.describe "user/venues/index.html.erb", type: :view do
  it 'should display no venues if there are no stored venues' do
    render

    expect(rendered).to match /No venues/
  end

  it 'should display all venues' do
    assign(:venues, [FactoryGirl.create(:venue, name: 'venue 1'),
                     FactoryGirl.create(:venue, name: 'venue 2')])

    render

    expect(rendered).to match /venue 1/
    expect(rendered).to match /venue 2/
  end
end
