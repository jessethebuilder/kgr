require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ build :user }

  describe 'Validations' do
    it{ should validate_presence_of :email }
    it{ should validate_presence_of :password }
  end

  describe 'Associations' do
    it{ should have_one :dj }
  end

  describe 'Attributes' do
    specify ':admin should default to false' do
      user.admin.should == false
    end
  end

  describe 'Class Methods' do
    # describe 'User.djs' do
    #   let!(:user){ create :user }
    #   let!(:dj){ create :dj }
    #
    #   it 'should return djs' do
    #     User.djs.should == [dj]
    #   end
    #
    #   it 'should not return users that are not djs' do
    #     User.djs.include?(user).should == false
    #   end
    # end
  end
end
