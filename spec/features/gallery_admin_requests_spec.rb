require 'rails_helper'

describe 'Gallery Admin Requests', type: :feature do
  let(:admin){ manual_login(create(:admin)) }
  let(:user){ manual_login(create(:user)) }
  let!(:gallery){ create :gallery }

  describe '#Show' do
    specify 'Add Image link should show if user is signed in as admin' do
      admin
      visit "/galleries/#{gallery.slug}"
      within('ul.quick_options') do
        page.should have_link('Add Image')
      end
    end

    specify 'Add Image link should not appear if user is not admin' do
      user
      visit "/galleries/#{gallery.slug}"
      page.should_not have_css('.quick_options')
    end

    specify 'Add Image link should not appear if user is not signed in' do
      visit "/galleries/#{gallery.slug}"
      page.should_not have_css('.quick_options')
    end

    specify 'If ADMIN is signed in, images should have edit and delete link' do
      gallery.gallery_images << create(:gallery_image)

      admin

      visit "/galleries/#{gallery.slug}"

      within('.gallery_image_name') do
        page.should have_link('Edit')
        page.should have_link('Delete')
      end
    end
  end # Show
end