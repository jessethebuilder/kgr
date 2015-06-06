require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event){ build :event }

  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :start_time }
  end

  describe 'Associations' do
    it{ should have_one :address }
  end

  describe 'Attributes' do
    describe ':djs_attending' do
      it 'should be an array' do
        event.djs_attending.class.should == Array
      end

      specify 'you can add elements to it' do
        x = Random.rand(1..10000)
        event.djs_attending << x
        event.djs_attending.last.should == x
      end
    end
  end
end
