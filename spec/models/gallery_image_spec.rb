require 'rails_helper'

RSpec.describe GalleryImage, type: :model do
  describe 'Validations' do
    it{ should validate_presence_of :image }
  end

  describe 'Associations' do
    it{ should belong_to :gallery }
  end
end
