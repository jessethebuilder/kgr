require 'rails_helper'

describe 'News Story Requests', :type => :feature do
  let(:title){ Faker::Company.name.titlecase }

  describe 'Farm Slugs' do
    specify 'They should work' do
      create :news_story, :title => title
      visit "/news_stories/#{title.parameterize}"
      page.status_code.should == 200
      page.should have_content(title)
    end
  end

  describe 'Creating a News Story' do
    def min
      visit 'news_stories/new'
      fill_in 'Title', with: title
    end

    it 'should create a News Story with the minimum values' do
      min
      expect{ click_button('Publish')}.to change{ NewsStory.count }.by(1)
    end
  end
end