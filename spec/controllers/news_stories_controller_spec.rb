require 'rails_helper'

describe NewsStoriesController, type: :controller do
  let(:valid_attributes){ attributes_for :news_story }
  let(:invalid_attributes){ {:title => ''} }
  let(:valid_session){ {} }

  describe 'GET #index' do
    describe '@news_story assign' do
      before(:each) do
        create(:news_story) #draft
        create(:news_story, :published => true)
        create(:news_story, :archived => true)
      end

      it "assigns all NewsStories as @news_stories IF user is admin" do
        login_user(create :admin)
        get :index, {}, valid_session
        assigns(:news_stories).count.should == 3
      end

      it "assigns only Published news stories if admin is not signed in" do
        login_user(create :user)
        get :index, {}, valid_session
        assigns(:news_stories).count.should == 1
      end

      it "assigns only Published news stories if user is not signed in" do
        get :index, {}, valid_session
        assigns(:news_stories).count.should == 1
      end
    end

    it "assigns all Events as @calendar_events" do
      e = create(:event)
      get :index, {}, valid_session
      expect(assigns(:calendar_events)).to eq([e])
    end

  end
end