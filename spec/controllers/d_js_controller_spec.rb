require 'rails_helper'

RSpec.describe DjsController, type: :controller do
  let(:user){ login_user(create :user) }
  let(:admin){ login_user(create :admin) }

  let(:valid_attributes) {
    attributes_for(:dj)
  }

  let(:invalid_attributes) {
    {:name => ''}
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    let!(:dj_draft){ Dj.create valid_attributes }
    let!(:dj_pub){ Dj.create valid_attributes }
    before(:each) do
      dj_pub.publish
    end

    it "assigns all published djs as @djs if no user is signed in" do
      get :index, {}, valid_session
      expect(assigns(:djs)).to eq([dj_pub])
    end

    it "assigns all djs to @djs if user is admin" do
      login_user(create :admin)
      get :index, {}, valid_session
      assigns(:djs).count.should == 2
    end

    it "assigns all PUBLISHED Events to @calendar_events" do
      event_pub = create(:event, :published => true)
      event_draft = create(:event)

      get :index, {}, valid_session
      assigns(:calendar_events).should == [event_pub]
    end


  end

  describe "GET #show" do
    it "assigns the requested dj as @dj" do
      dj = Dj.create! valid_attributes
      get :show, {:id => dj.to_param}, valid_session
      expect(assigns(:dj)).to eq(dj)
    end

    it "assigns any PUBLISHED Events the DJ is attending to @calendar_events" do
      dj = Dj.create! valid_attributes
      e1 = create :event, :published => true
      e2 = create :event

      e1.users << dj.user
      e1.save
      e2.users << dj.user
      e2.save

      get :show, {:id => dj.to_param}, valid_session
      expect(assigns(:calendar_events)).to eq([e1])
    end
  end

  describe "GET #new" do
    #refractor this into general spec in support
    ####\
    #
    #

    describe 'When Admin is signed in' do
      before(:each){ admin }

      it 'should render the new template' do
        get :new, {}, valid_session
        expect(response).to render_template('new')
      end

      it "assigns a new dj as @dj" do
        get :new, {}, valid_session
        expect(assigns(:dj)).to be_a_new(Dj)
      end
    end

    describe 'When user is signed in' do
      before(:each){ user }

      it 'should redirect to sign in' do
        get :new, {}, valid_session
        expect(response).to redirect_to("/")
      end
    end

    describe 'Guest' do
      it 'should redirect to sign in' do
        get :new, {}, valid_session
        expect(response).to redirect_to("/d/users/sign_in")
      end
    end
  end

  describe "GET #edit" do
    let!(:dj){ Dj.create! valid_attributes }

    describe 'When Admin' do
      before(:each) do
        admin
        get :edit, {:id => dj.to_param}, valid_session
      end

      it 'renders edit' do
        expect(response).to render_template('edit')
      end

      it "assigns the requested dj as @dj" do
        expect(assigns(:dj)).to eq(dj)
      end
    end

    describe 'When User' do
      before(:each) do
        user
        get :edit, {:id => dj.to_param}, valid_session
      end

      it 'to Root' do
        expect(response).to redirect_to("/")
      end
    end

    describe 'When Guest' do
      before(:each) do
        get :edit, {:id => dj.to_param}, valid_session
      end

      it 'to Login' do
        expect(response).to redirect_to("/d/users/sign_in")
      end

      it 'should have flash message' do
        within('.flash') do
          page.should have_content 'You must be an Administrator to view that page'
        end
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Dj" do
        expect {
          post :create, {:dj => valid_attributes, :commit => 'Publish'}, valid_session
        }.to change(Dj, :count).by(1)
      end

      it "assigns a newly created dj as @dj" do
        post :create, {:dj => valid_attributes, :commit => 'Publish'}, valid_session
        expect(assigns(:dj)).to be_a(Dj)
        expect(assigns(:dj)).to be_persisted
      end

      it "redirects to the created dj" do
        post :create, {:dj => valid_attributes, :commit => 'Publish'}, valid_session
        expect(response).to redirect_to(Dj.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved dj as @dj" do
        post :create, {:dj => invalid_attributes, :commit => 'Publish'}, valid_session
        expect(assigns(:dj)).to be_a_new(Dj)
      end

      it "re-renders the 'new' template" do
        post :create, {:dj => invalid_attributes, :commit => 'Publish'}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:dj, :name => 'A New Name')
      }

      it "updates the requested dj" do
        dj = Dj.create! valid_attributes
        put :update, {:id => dj.to_param, :dj => new_attributes, :commit => 'Publish'}, valid_session
        dj.reload
        dj.name.should == 'A New Name'
      end

      it "assigns the requested dj as @dj" do
        dj = Dj.create! valid_attributes
        put :update, {:id => dj.to_param, :dj => valid_attributes, :commit => 'Publish'}, valid_session
        expect(assigns(:dj)).to eq(dj)
      end

      it "redirects to the dj" do
        dj = Dj.create! valid_attributes
        put :update, {:id => dj.to_param, :dj => valid_attributes, :commit => 'Publish'}, valid_session
        expect(response).to redirect_to(dj)
      end
    end

    context "with invalid params" do
      it "assigns the dj as @dj" do
        dj = Dj.create! valid_attributes
        put :update, {:id => dj.to_param, :dj => invalid_attributes, :commit => 'Publish'}, valid_session
        expect(assigns(:dj)).to eq(dj)
      end

      it "re-renders the 'edit' template" do
        dj = Dj.create! valid_attributes
        put :update, {:id => dj.to_param, :dj => invalid_attributes, :commit => 'Publish'}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested dj" do
      dj = Dj.create! valid_attributes
      expect {
        delete :destroy, {:id => dj.to_param}, valid_session
      }.to change(Dj, :count).by(-1)
    end

    it "redirects to the djs list" do
      dj = Dj.create! valid_attributes
      delete :destroy, {:id => dj.to_param}, valid_session
      expect(response).to redirect_to(djs_url)
    end
  end

end