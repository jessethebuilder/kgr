require 'rails_helper'

describe 'Event Requests' do
  describe 'Farm Slugs' do
    specify 'they should work' do
      test_name = 'Test Event Name'
      create :event, :name => test_name
      visit "/events/#{test_name.parameterize}"
      page.status_code.should == 200
      page.should have_content(test_name)
    end
  end

  describe 'End to End' do
    it 'should accept the minimum values through the form, and save the object' do

    end

    it 'should accept all values through the from, and save them' do

    end
  end
end

def fill_in_minimum_values
  visit '/events/new'

end