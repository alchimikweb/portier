require "spec_helper"

describe ApplicationController do
  controller do
    before_filter :protect_app

    def current_user
      @user
    end

    def index
      if can_view?(:granted_response, show: true)
        render text: 'Granted!'
      else
        render text: 'Nothing'
      end
    end

    def create
      if can?(:create, :products)
        render text: "Created! #{permitted_params}"
      else
        render text: "Not Created!"
      end
    end

    def edit
      render text: 'Refused!'
    end

    def destroy
      render text: 'Destroyed!'
    end
  end

  describe "when calling an open action" do
    it 'should grant access' do
      get :index

      expect(response.status).to eq(200)
      expect(response.body).to eq "Granted!"
    end
  end

  describe "when calling a restricted action" do
    it 'should not grant access' do
      get :edit, id: '123'

      expect(response.status).to eq(401)
      expect(response.body).to eq "access_denied"
    end
  end

  describe "when sending the role and the role is not allowed to be sent" do
    it 'should not have role in the permitted_params' do
      post :create, anonymou: { name: '123', email: 'a@at.com', role: 'admin' }

      expect(response.status).to eq(200)
      expect(response.body).to include('email')
      expect(response.body).not_to include('role')
    end
  end

  describe "when deleting an open record" do
    it 'should grant access' do
      delete :destroy, id: 'open'

      expect(response.status).to eq(200)
      expect(response.body).to eq "Destroyed!"
    end
  end

  describe "when deleting an restricted record" do
    it 'should not grant access' do
      delete :destroy, id: 'restricted'

      expect(response.status).to eq(401)
      expect(response.body).to eq "access_denied"
    end
  end
end
