RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  describe 'GET #new' do
    before { login(user) }

    before { get :new, params: { question_id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login(user) }

    let(:create_post) { post :create, params: { question_id: question, answer: answer_params } }

    context 'with valid attributes' do
      let(:answer_params) { attributes_for(:answer) }

      it 'saves a new answer for question in the database' do
        expect { create_post }.to change(question.answers, :count).by(1)
      end

      it 'assigned to author' do
        create_post
        expect(assigns(:answer).author).to eq user
      end

      it 'redirects to question show view' do
        create_post
        expect(response).to redirect_to assigns(:answer).question
      end
    end

    context 'with invalid attributes' do
      let(:answer_params) { attributes_for(:answer, :invalid) }

      it 'does not save the answer' do
        expect { create_post }.not_to change(Answer, :count)
      end

      it 're-renders question show view' do
        create_post
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: answer } }

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    let(:delete_request) { delete :destroy, params: { id: answer } }

    context 'when user is an author' do
      let!(:answer) { create(:answer, author: user) }

      it 'deletes the answer' do
        expect { delete_request }.to change(user.answers, :count).by(-1)
      end

      it "redirects to answer's question show" do
        delete_request
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context 'when user is not an author' do
      let!(:answer) { create(:answer) }

      it 'does not delete the question' do
        expect { delete_request }.to_not change(Answer, :count)
      end
    end

    it "redirects to answer's question show" do
      delete_request
      expect(response).to redirect_to question_path(answer.question)
    end
  end
end
