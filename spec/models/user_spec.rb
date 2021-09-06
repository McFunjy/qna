RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:questions).dependent(:destroy) }
    it { is_expected.to have_many(:answers).dependent(:destroy) }
  end

  describe 'User #author_of?' do
    let(:user) { create(:user) }
    let(:question) { create(:question, author: user) }
    let(:question1) { create(:question) }

    it 'returns true if user is the author of resource' do
      expect(user).to be_author_of(question)
    end

    it 'returns false if user is not the author of resource' do
      expect(user).to_not be_author_of(question1)
    end
  end
end
