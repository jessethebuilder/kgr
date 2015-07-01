require 'rails_helper'

describe 'Home Page Requests', type: :feature do
  describe 'News Stories' do
    it 'should only show the last 4 published news stories' do
      first_story = create(:published_story)
      3.times{ create(:published_story) }

      visit '/pages/home'
      within('.recent_news_stories') do
        page.should have_content first_story.title
      end

      create(:published_story)
      visit '/pages/home'
      within('.recent_news_stories') do
        page.should_not have_content first_story.title
      end
    end

    it 'should not list draft stories' do
      story = create(:news_story)
      visit '/'
      within('.recent_news_stories') do
        page.should_not have_content story.title
      end
    end

    describe 'More Stories link' do
      before(:each) do
        4.times do
          create(:published_story)
        end
      end

      specify 'if there are fewer than 4 published stories, link should not appear' do
        visit '/'
        within('.recent_news_stories') do
          page.should_not have_link 'more stories >>'
        end
      end

      it 'should show the more stories link, if there are more than 4 published stories' do
        create(:published_story)
        visit '/'
        within('.recent_news_stories') do
          page.should have_link 'more stories >>'
        end
      end

    end
  end

end