feature 'User can view a list of questions', %q{
  In order to view existing questions
  As an user
  I'd like to be able to view a list of questions
} do
  scenario 'User views all questions' do
    create_list(:question, 2)

    visit root_path

    expect(page).to have_content 'All Questions'
    expect(page).to have_content 'MyQuestion', count: 2
    expect(page).to have_content 'MyText', count: 2
  end
end