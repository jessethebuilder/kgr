require 'rails_helper'

describe 'Event Save Draft Archive Delete Requests', type: :feature do
  let!(:event){ create :event }
  let!(:admin){ manual_login(create(:admin)) }

  before(:each) do
    visit "/events/#{event.to_param}/edit"
  end

  describe 'Editing the publication status of an Event' do
    specify 'a newly created event should be a draft' do
      within('#publication_status') do
        page.should have_content 'draft'
      end
    end

    specify 'clicking Publish saves as published' do
      click_button 'Publish'
      event.reload
      event.publication_status.should == 'published'

      visit "/events/#{event.to_param}/edit"
      within('#publication_status') do
        page.should have_content 'published'
      end
    end

    specify 'clicking "Save Draft" on a published event will save it as draft' do
      click_button 'Publish'
      visit "/events/#{event.to_param}/edit"

      click_button "Save Draft"

      event.reload

      event.publication_status.should == 'draft'
      visit "/events/#{event.to_param}/edit"
      within('#publication_status') do
        page.should have_content 'draft'
      end
    end

    specify 'clicking "Archive" archives a document' do
      click_button 'Archive'
      event.reload
      event.publication_status.should == 'archived'
    end

    specify 'clicking "Delete" deletes a document' do
      expect{ click_link('Delete') }.to change{ Event.count }.by(-1)
    end
  end


end