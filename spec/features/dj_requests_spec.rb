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
    let(:email){ Faker::Internet.email }

    def min
      manual_login(create(:admin))
      visit "/djs/new"
      fill_in 'Name', with: name
      fill_in 'Email', with: email
    end

    specify 'saves with the minimum params' do
      min
      expect{ click_button 'Publish' }.to change{ Dj.count }.by(1)
    end

    it 'should save the minimum params' do
      min
      click_button 'Publish'
      dj = Dj.last
      dj.name.should == name
      dj.email.should == email
    end

    it 'should accept keywords' do
      min
      words = Faker::Lorem.words(num = Random.rand(1..1000)).join(', ')
      fill_in 'Keywords', with: words
      click_button 'Publish'
      Dj.last.keywords.should == words
    end

    it 'should save description' do
      bio = Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..20)).join('<br><br>')
      min
      fill_in 'Full bio', with: bio
      click_button 'Publish'
      Dj.last.bio.should == bio
    end

    it 'should save Short Bio' do
      short_bio = Faker::Lorem.sentences(sentence_count = 4).join('. ')
      min
      fill_in 'Short bio', with: short_bio
      click_button 'Publish'
      Dj.last.short_bio.should == short_bio
    end

  end  #Dj Creation




end