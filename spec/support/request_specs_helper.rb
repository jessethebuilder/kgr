module RequestSpecsHelper
  PW = 'lassiter'

  def manual_login(user)
    visit '/d/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: PW
    click_button 'Log in'
    user
  end
end

module AuthRequestSpecsHelper
  def basic_authentication_requests(controller)
    describe 'Authentication Requests' do
      let(:admin){ manual_login(create(:admin))}
      let(:user){ manual_login(create(:user))}

      describe 'New' do
        before(:each){ visit "/#{controller}/new" }

        context 'Admin' do
          before(:each){ admin }
          it 'should Allow' do
            page.current_path.should == "/#{controller}/new"
          end
        end # Admin

        context 'User' do
          before(:each){ user }

          specify 'User should be redirected to login form' do
            page.current_path.should == "/d/users/sign_in"
          end

          it 'should have flash message' do
            within('.flash') do
              page.should have_content 'You must be an Administrator to view that page'
            end
          end
        end

        context 'Guest' do
          specify 'Guest should be redirected to login form' do
            page.current_path.should == "/d/users/sign_in"
          end

          it 'should have flash message' do
            within('.flash') do
              page.should have_content 'You must be an Administrator to view that page'
            end
          end
        end # Guest
      end # New
    end

  end
end