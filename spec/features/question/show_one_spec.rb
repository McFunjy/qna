feature 'User can view the question and the answers to it', %q{
  In order to get answer for question
  As an user
  I'd like to be able to view the question with available answers
} do
  scenario 'view the question with available answers' do
    question = create(:question)
    question.answers = create_list(:answer, 2)

    visit question_path(question)

    expect(page).to have_content 'MyQuestion'
    expect(page).to have_content 'MyText'
    expect(page).to have_content 'MyAnswer', count: 2
  end
end
