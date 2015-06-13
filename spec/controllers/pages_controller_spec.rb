require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end

    describe 'News Stories' do
      it "should assign PUBLISHED NewsStories to @news_story" do
        ns_published = build(:news_story)
        ns_published.publish
        ns_published.save!

        ns_draft = create(:news_story)

        get :home

        assigns(:news_stories).include?(ns_published).should == true
        assigns(:news_stories).include?(ns_draft).should == false
      end

      it 'should assign only the first 6 published news stories' do
        7.times do
          create(:news_story, published: true)
        end

        get :home
        assigns(:news_stories).count.should == 6
      end
    end
  end

  describe "GET #contact_us" do
    it "returns http success" do
      get :contact_us
      expect(response).to have_http_status(:success)
    end
  end

end
