require 'rails_helper'

describe 'Event Requests for Admin' do
  let(:admin){ manual_login(create(:admin)) }
  let(:user){ manual_login(create(:user)) }

  let!(:event){ create :event }

  describe 'Show' do
    it 'should show the edit link, if user is admin' do
      admin
      visit "/events/#{event.to_param}"
      within('.quick_options') do
        page.should have_link 'Edit'
        click_link 'Edit'
        page.current_path.should == "/events/#{event.to_param}/edit"
      end
    end

    it 'should not show edit link if the user is not admin' do
      user
      visit "/events/#{event.to_param}"
      visit "/events/#{event.to_param}"
      page.should_not have_css('.quick_options')
    end

    it 'should not have edit likn, if user is not sigend in' do
      visit "/events/#{event.to_param}"
      page.should_not have_css('.quick_options')
    end
  end
end