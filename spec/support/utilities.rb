def sign_in
  visit login_path
  fill_in "Email",    with: 'test@user.com'
  fill_in "Password", with: 'testpass'
  click_button "Log In" 
end