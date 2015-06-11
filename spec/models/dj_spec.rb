require 'rails_helper'

RSpec.describe Dj, type: :model do
  let(:dj){ build :dj }

  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :email}

  end

  describe 'Associations' do
    it{ should have_one :show }
    it{ should belong_to :user }
  end

  describe 'Idioms' do
    describe 'DJ / User relation' do
      specify 'when a DJ is created, and there is no user with a matching email, a User is created an associated with the DJ' do
        # expect{ dj = create(:dj) }.to change{ User.count }.by(1)
        dj = Dj.new(:name => 'xxxxxx', :email => 'alan@xxx.com')
        dj.save!
        dj.user.should == User.last
      end

      specify 'if a User exists with a matching email, it is associated with the user' do
        test_email = 'specialtest@testy.net'
        u = create(:user, email: test_email)
        dj = create(:dj, email: test_email)

        dj.user.should == u
      end
    end
  end

  describe 'Methods' do
    describe '#facebook_page' do
      it 'should return the name of the facebook page from :facebook_url' do
        dj.facebook_url = 'https://www.facebook.com/thetestuser'
        dj.facebook_page.should == 'thetestuser'
      end

      it 'should work even if the "http:// is omitted' do
        dj.facebook_url = 'www.facebook.com/anothertestuser'
        dj.facebook_page.should == 'anothertestuser'
      end

      it 'should return nil if :facebook_url is nil' do
        dj.facebook_url.should == nil
        dj.facebook_page.should == nil
      end
    end
  end
end
