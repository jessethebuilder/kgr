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

    it 'should accept :keywords' do
      keywords = Faker::Lorem.words(word_count = Random.rand(1..100)).join(', ')
      min
      fill_in 'Keywords', :with => keywords
      click_button 'Save Draft'

      Show.last.keywords.should == keywords
    end

    it 'should accept :description' do
      des = Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..15)).join('<br>')
      min
      fill_in 'Description', with: des
      click_button 'Publish'

      Show.last.description.should == des
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