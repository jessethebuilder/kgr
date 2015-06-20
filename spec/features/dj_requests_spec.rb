require 'rails_helper'

describe 'Dj Requests' do
  describe 'Farm Slugs' do
    specify 'they should work' do
      test_name = 'Test Event Name'
      create :dj, :name => test_name
      visit "/djs/#{test_name.parameterize}"
      page.status_code.should == 200
      page.should have_content(test_name)
    end
  end

  describe 'Dj Creation' do
    let(:name){ 'Test Name' }
    let(:description){ Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..20)).join('<br><br>') }
    let(:keywords){ Faker::Lorem.words(num = Random.rand(1..1000)).join(', ') }
    let(:email){ Faker::Internet.email }

    def min
      visit "/djs/new"
      fill_in 'dj_name', with: name
      fill_in 'Email', with: email
    end

    specify 'saves with the minimum params' do
      min
      expect{ click_button 'Publish' }.to change{ Dj.count }.by(1)
    end

    specify 'Show variables should save' do
      min
      within('#show_information_col') do
        fill_in 'Name', with: 'Test Show Name'
      end

      click_button 'Publish'
      Dj.last.show.name.should == 'Test Show Name'
    end
  end  #Dj Creation



end