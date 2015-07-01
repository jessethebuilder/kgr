require 'rails_helper'

describe NewsStoriesController, type: :controller do
  let(:valid_attributes){ attributes_for :news_story }
  let(:invalid_attributes){ {:title => ''} }
  let(:valid_session){ {} }

  describe 'GET #index' do
    it 'should assign all PUBLISHED events to @calendar_events' do
      pub = create(:published_event)
      draft = create(:draft_event)

      get :index, {}, valid_session
      assigns(:calendar_events).should == [pub]
    end

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

      it 'orders NewsStories based on updated_at' do
        first_story = create(:published_story)
        second_story = create(:published_story)

        get :index, {}, valid_session
        assigns(:news_stories).first.should == second_story

        first_story.title = 'New Title'
        first_story.save!

        get :index, {}, valid_session
        assigns(:news_stories).first.should == first_story
      end
    end
  end

  describe 'GET #show' do
    it "assigns the requested news_story as @news_story" do
      news_story = NewsStory.create! valid_attributes
      get :show, {:id => news_story.to_param}, valid_session
      expect(assigns(:news_story)).to eq(news_story)
    end

    it 'should assign all PUBLISHED events to @calendar_events' do
      news_story = NewsStory.create! valid_attributes
      
      pub = create(:published_event)
      draft = create(:draft_event)

      get :show, {:id => news_story.to_param}, valid_session
      assigns(:calendar_events).should == [pub]
    end
  end

  describe "GET #new" do
    it "assigns a new NewsStory as @news_story" do
      get :new, {}, valid_session
      expect(assigns(:news_story)).to be_a_new(NewsStory)
    end
  end

  describe "GET #edit" do
    it "assigns the requested news_story as @news_story" do
      news_story = NewsStory.create! valid_attributes
      get :edit, {:id => news_story.to_param}, valid_session
      expect(assigns(:news_story)).to eq(news_story)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new NewsStory" do
        expect {
          post :create, {:news_story => valid_attributes, :commit => 'Publish'}, valid_session
        }.to change(NewsStory, :count).by(1)
      end

      it "assigns a newly created event as @news_story" do
        post :create, {:news_story => valid_attributes, :commit => 'Publish'}, valid_session
        expect(assigns(:news_story)).to be_a(NewsStory)
        expect(assigns(:news_story)).to be_persisted
      end

      it "redirects to the created event" do
        post :create, {:news_story => valid_attributes, :commit => 'Publish'}, valid_session
        expect(response).to redirect_to(NewsStory.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved news_story as @news_story" do
        post :create, {:news_story => invalid_attributes, :commit => 'Publish'}, valid_session
        expect(assigns(:news_story)).to be_a_new(NewsStory)
      end

      it "re-renders the 'new' template" do
        post :create, {:news_story => invalid_attributes, :commit => 'Publish'}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:news_story, :title =>'A New Name for This')
      }

      it "updates the requested event" do
        news_story = NewsStory.create! valid_attributes
        put :update, {:id => news_story.to_param, :news_story => new_attributes, :commit => 'Publish'}, valid_session
        news_story.reload
        news_story.title.should == 'A New Name for This'
      end

      it "assigns the requested news_story as @news_story" do
        news_story = NewsStory.create! valid_attributes
        put :update, {:id => news_story.to_param, :news_story => valid_attributes, :commit => 'Publish'}, valid_session
        expect(assigns(:news_story)).to eq(news_story)
      end

      it "redirects to the event" do
        news_story = NewsStory.create! valid_attributes
        put :update, {:id => news_story.to_param, :news_story => valid_attributes, :commit => 'Publish'}, valid_session
        expect(response).to redirect_to(news_story)
      end
    end

    context "with invalid params" do
      it "assigns the news_story as @news_story" do
        news_story = NewsStory.create! valid_attributes
        put :update, {:id => news_story.to_param, :news_story => invalid_attributes, :commit => 'Publish'}, valid_session
        expect(assigns(:news_story)).to eq(news_story)
      end

      it "re-renders the 'edit' template" do
        news_story = NewsStory.create! valid_attributes
        put :update, {:id => news_story.to_param, :news_story => invalid_attributes, :commit => 'Publish'}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested event" do
      news_story = NewsStory.create! valid_attributes
      expect {
        delete :destroy, {:id => news_story.to_param}, valid_session
      }.to change(NewsStory, :count).by(-1)
    end

    it "redirects to the news_stories list" do
      news_story = NewsStory.create! valid_attributes
      delete :destroy, {:id => news_story.to_param}, valid_session
      expect(response).to redirect_to(news_stories_url)
    end
  end

end