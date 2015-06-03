require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #contact_us" do
    it "returns http success" do
      get :contact_us
      expect(response).to have_http_status(:success)
    end
  end

end
