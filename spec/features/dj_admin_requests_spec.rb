require 'rails_helper'

describe 'Dj Admin Requests', type: :feature do
  let(:admin){ manual_login(create(:admin))}
  let(:user){ manual_login(create(:user))}

  describe 'New' do
    # before(:each){ visit '/djs/new' }

    context 'Admin' do
      before(:each) do
        admin
        visit "/djs/new"
      end

      it 'should show New' do
        page.current_path.should == "/djs/new"
      end

      # it 'should render form' do
      #   page.should have_css('#new_dj')
      # end
    end # Admin

    context 'User' do
      before(:each) do
        user
        visit "/djs/new"
      end

      specify 'User should be redirected to the root' do
        page.current_path.should == "/"
      end

      it 'should have flash message' do
        within('.flash') do
          page.should have_content 'You must be an Administrator to view that page'
        end
      end
    end

    context 'Guest' do
      before(:each) do
        visit "/djs/new"
      end

      specify 'Guest should be redirected to login form' do
        page.current_path.should == "/d/users/sign_in"
      end


      it 'should have flash message' do
        within('.flash') do
          page.should have_content 'You must be an Administrator to view that page'
        end
      end
    end # Guest
  end # New

  describe 'Create' do
    before(:each) do
      visit '/djs/new'
      fill_in 'Name', with: Faker::Name.name
      fill_in 'Email', with: Faker::Internet.email
      click_button 'Publish'
    end

    context 'Admin' do
      context 'Publishing a New Dj' do

        specify 'After create, should render the show page' do
          page.current_path.should == "/djs/#{Dj.last.slug}"
        end

        specify 'A user should be created along with the new Dj' do
          Dj.last.user.should_not == nil
        end

      end
    end

  end # create
end

#
# before(:each){ admin }
# it 'Should indicate the publication status is "draft"' do
#   within('.publication_status') do
#     page.should have_content 'draft'
#   end
# end
