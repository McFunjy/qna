feature 'Author can delete his answer', %q{
  In order to remove the answer
  As the author of the answer
  I'd like to be able to delete my answer
} do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
    end

    scenario 'deletes his question' do
      user.answers.push(answer)

      visit question_path(question)
      click_on 'Delete Answer'

      expect(page).to have_content 'Your answer successfully deleted.'
      expect(page).not_to have_content answer.body
    end

    scenario "tries to delete someone else's answer" do
      visit question_path(question)

      expect(page).not_to have_link 'Delete Answer'
    end
  end

  scenario 'Unauthenticated user tries to delete answer' do
    visit question_path(question)

    expect(page).not_to have_link 'Delete Answer'
  end
end
