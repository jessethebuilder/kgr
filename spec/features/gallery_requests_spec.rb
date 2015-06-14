require 'rails_helper'

describe 'Gallery Requests', type: :feature do
  describe 'Farm Slugs' do
    it 'should use them' do
      create(:gallery, name: 'A Gallery Name')
      visit "/galleries/a-gallery-name"
      page.status_code.should == 200
    end
  end
end