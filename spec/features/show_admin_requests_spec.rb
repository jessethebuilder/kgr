require 'rails_helper'

describe 'Show Admin Requests', type: :feature do
  let(:admin){ manual_login(create(:admin)) }
  let(:user){ manual_login(create(:user)) }

  let!(:event){ create :event }

  describe 'Index' do
    it 'should have "New" like if user is signed in as admin' do
      admin
      visit "/shows"
      within('.quick_options') do
        page.should have_link('New')
        click_link 'New'
      end

      page.current_path.should == '/shows/new'
    end

    it 'should not have "New" link if user is not an admin' do
      user
      visit "/shows"
      page.should_not have_css('.quick_options')
    end

    it 'should not have "New" link if user is not signed in' do
      visit "/shows"
      page.should_not have_css('.quick_options')
    end
  end

  describe 'Show Page' do

  end
end