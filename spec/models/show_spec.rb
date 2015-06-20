require 'rails_helper'

RSpec.describe Show, type: :model do
  describe 'Validations' do
    it{ should validate_presence_of :name }


  end

  describe 'Associations' do
    it{ should have_many(:talent_fors) }
    it{ should have_many(:users).through(:talent_fors) }
  end
end
