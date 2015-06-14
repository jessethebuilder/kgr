require 'rails_helper'

RSpec.describe Gallery, type: :model do
  describe 'Validations' do
    it{ should validate_presence_of :name }
  end

  describe 'Associations' do
    it{ should have_many :gallery_images }
  end
end
