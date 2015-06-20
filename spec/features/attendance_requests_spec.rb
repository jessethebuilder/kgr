require 'rails_helper'

describe 'Attendance Requests', type: :feature do
  describe 'Creating and Deleting through the Event form' do
    let!(:event){ create :event }
    let!(:dj1){ create :dj }
    let!(:dj2){ create :dj }

    before(:each) do
      visit "/events/#{event.to_param}/edit"
    end

    it 'should create an attendance when a Dj is checked and the form is saved' do
      check dj1.name
      expect{ click_button 'Publish' }.to change{ Attendance.count }.by(1)
    end

    it 'should destroy an attendance when a Dj is unchecked' do
      check dj1.name
      click_button 'Publish'
      visit "/events/#{event.to_param}/edit"

      uncheck dj1.name
      expect{ click_button 'Publish' }.to change{ Attendance.count }.by(-1)
    end
  end
end