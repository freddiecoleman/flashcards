def register
  visit signup_path
  fill_in 'Email',    with: 'test@user.com'
  fill_in 'Password', with: 'testpass'
  fill_in 'Password confirmation', with: 'testpass'
  click_button "Create User"
end
def create_deck
  visit decks_path
  fill_in 'Name', with: 'test deck'
  click_button 'Create Deck'
end
def create_flashcard
visit flashcards_path
fill_in 'Front', with: 'this is testing the front of a flashcard'
fill_in 'Back', with: 'this is testing the back of a flashcard'
select('test deck',:from=> 'Deck')
click_button 'Create Flashcard'
end
def sign_in
  visit login_path
  fill_in "Email",    with: 'test@user.com'
  fill_in "Password", with: 'testpass'
  click_button "Log In" 
end