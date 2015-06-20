require 'rails_helper'

RSpec.describe TalentFor, type: :model do
  describe 'Associations' do
    it{ should belong_to :user }
    it{ should belong_to :show }
  end
end
