require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event){ build :event }

  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :start_time }
  end

  describe 'Associations' do
    it{ should have_one :address }

    describe 'Address' do
      it 'should geocode the address upon save' do
        a = event.address
        a.street = '4218 S. Mt. Angeles Rd'
        a.zip = '98362'

        a.latitude.should == nil

        event.save!

        a.geocoded?.should == true
      end
    end
  end

  describe 'Attributes' do
  #   describe ':djs_attending' do
  #     it 'should be an array' do
  #       event.djs_attending.class.should == Array
  #     end
  #
  #     specify 'you can add Users to it' do
  #       u = create(:user)
  #       event.djs_attending << u
  #       event.djs_attending.last.should == u
  #     end
  #   end
  end
end
