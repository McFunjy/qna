feature 'User can sign out', %q{
  In order to stop interacting with the system
  As an authenticated user
  I'd like to be able to sign out
} do
  given(:user) { create(:user) }

  scenario 'sign out' do
    sign_in(user)
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end
end
