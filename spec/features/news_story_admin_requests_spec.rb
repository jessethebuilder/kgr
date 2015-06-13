require 'rails_helper'

describe 'News Story Admin Requests', type: :feature do
  let(:admin){ manual_login(create(:admin)) }
  let(:user){ manual_login(create(:user)) }

  let!(:news_story){ create(:news_story, published: true) }

  describe 'News Story Requests' do

    describe 'Index' do
      specify 'if admin is signed in, Edit should be available' do
        admin
        visit '/news_stories'
        within('ul.quick_options') do
          page.should have_link 'New'
        end
      end

      specify 'if user is not admin, Edit is not available' do
        user
        visit '/news_stories'
        page.should_not have_css('.quick_options')
      end

      specify 'if user is not signed in, Edit is NOT avail' do
        visit '/news_stories'
        page.should_not have_css('.quick_options')
      end

      describe 'Edit links in NewsStory table' do
        specify 'if admin is signed in, name link should direct to :edit' do
          admin
          visit '/news_stories'
          click_link news_story.title
          page.current_path.should == "/news_stories/#{news_story.slug}/edit"
        end

        specify 'if user is signed in, but not admin, directs to :show' do
          user
          visit '/news_stories'
          click_link news_story.title
          page.current_path.should == "/news_stories/#{news_story.slug}"
        end

        specify 'if user is not signed in, name link directs to :show' do
          visit '/news_stories'
          click_link news_story.title
          page.current_path.should == "/news_stories/#{news_story.slug}"
        end

      end
    end # Index

    describe 'Show' do
      describe 'Title' do
        specify 'if user is admin, Title should link to edit' do
          admin
          visit "/news_stories/#{news_story.slug}"
          click_link news_story.title
          page.current_path.should == "/news_stories/#{news_story.slug}/edit"
        end

        specify 'if user is not signed in, Title should not be a link' do
          user
          visit "/news_stories/#{news_story.slug}"
          within('h1') do
            page.should_not have_link(news_story.title)
          end
        end

        specify 'if user is not signed in, Title should not be a link' do
          visit "/news_stories/#{news_story.slug}"
          within('h1') do
            page.should_not have_link(news_story.title)
          end
        end

      end
    end # Show
  end # NewsStory Requests
end