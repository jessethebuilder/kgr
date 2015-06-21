require 'rails_helper'

RSpec.describe Show, type: :model do
  let(:show){ build :show }

  describe 'Validations' do
    it{ should validate_presence_of :name }


  end

  describe 'Associations' do
    it{ should have_many(:talent_fors) }
    it{ should have_many(:users).through(:talent_fors) }
  end

  describe 'Idioms' do
    it 'should use farm_slugs' do
      show.name = 'A Show Name'
      show.save!

      Show.find('a-show-name').should == show
    end
  end

  describe 'Attributes' do
    describe 'Farm Slug Attributes' do
      specify 'published should default as false' do
        Show.new.published.should == false
      end

      specify ':archived should default as false' do
        Show.new.published.should == false
      end
    end
  end # Attributes

  describe 'Methods' do
    describe '#djs' do
      it 'should return the djs for any user added to it' do
        dj = create(:dj)
        show.users << dj.user

        show.djs.should == [dj]
      end
    end
  end # Methods
end
