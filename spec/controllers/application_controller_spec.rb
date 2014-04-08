require "spec_helper"

describe ApplicationController do
  controller do
    before_filter :protect_app

    def current_user
      @user
    end

    def index
      render text: 'Granted!'
    end

    def create
      render text: "Created! #{permitted_params}"
    end

    def edit
      render text: 'Refused!'
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
end
