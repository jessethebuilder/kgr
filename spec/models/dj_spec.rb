require 'rails_helper'

RSpec.describe Dj, type: :model do
  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :tag_line }

  end
end
