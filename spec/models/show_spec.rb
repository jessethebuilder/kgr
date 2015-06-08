require 'rails_helper'

RSpec.describe Show, type: :model do
  describe 'Validations' do

  end

  describe 'Associations' do
    it{ should belong_to :dj }
  end
end
