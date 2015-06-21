require 'rails_helper'

describe 'Show Requests', type: :feature do
  let(:show){ create :show }

  describe 'New Shows' do
    def min
      manual_login(create(:admin))
      visit '/shows/new'
      fill_in 'Name', with: Faker::Business.name
    end

    it 'should save a new show with the minimum parameters' do
      min
      expect{ click_button 'Publish' }.to change{ Show.count }.by(1)
    end

    describe 'Adding Djs' do
      let!(:dj1){ create :dj }
      let!(:dj2){ create :dj }

      specify 'Checking a dj box adds a Dj to the show' do
        min
        check dj1.name
        expect{ click_button 'Publish' }.to change{ TalentFor.count }.by(1)

        s = Show.last
        s.users.include?(dj1.user).should == true

        visit "/djs/#{dj1.to_param}"
        within('.show') do
          page.should have_content s.name
        end
      end
    end
  end
end