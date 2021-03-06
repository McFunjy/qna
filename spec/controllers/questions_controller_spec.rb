RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before { login(user) }

    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login(user) }

    let(:create_post) { post :create, params: { question: question_params } }

    context 'with valid attributes' do
      let(:question_params) { attributes_for(:question) }

      it 'saves a new question in the database' do
        expect { create_post }.to change(user.questions, :count).by(1)
      end

      it 'redirects to show view' do
        create_post
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      let(:question_params) { attributes_for(:question, :invalid) }

      it 'does not save the question' do
        expect { create_post }.not_to change(Question, :count)
      end

      it 're-renders new view' do
        create_post
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    let(:delete_request) { delete :destroy, params: { id: question } }

    context 'when user is an author' do
      let!(:question) { create(:question, author: user) }

      it 'deletes the question' do
        expect { delete_request }.to change(user.questions, :count).by(-1)
      end

      it 'redirects to index' do
        delete_request
        expect(response).to redirect_to questions_path
      end
    end

    context 'when user is not an author' do
      let!(:question) { create(:question) }

      it 'does not delete the question' do
        expect { delete_request }.not_to change(Question, :count)
      end

      it 'redirects to show' do
        delete_request
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end
