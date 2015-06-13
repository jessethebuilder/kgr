module RequestSpecsHelper
  PW = 'lassiter'

  def manual_login(user)
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: PW
    click_button 'Log in'
    user
  end
end