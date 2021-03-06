RSpec.describe Question, type: :model do
  it { is_expected.to belong_to(:author).class_name('User') }

  it { is_expected.to have_many(:answers).dependent(:destroy) }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
end
