require "spec_helper"

#describe ApplicationController do
#end

describe ApplicationController, :type => :controller do
  controller do
    before_action :protect_app

    def current_user
      @user
    end

    def index
      if can_view?(:granted_response, show: true)
        render plain: 'Granted!'
      else
        render plain: 'Nothing'
      end
    end

    def create
      if can?(:create, :products)
        render plain: "Created! #{permitted_params}"
      else
        render plain: "Not Created!"
      end
    end

    def edit
      render plain: 'Refused!'
    end

    def destroy
      render plain: 'Destroyed!'
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
      get :edit, params: { id: '123' }

      expect(response.status).to eq(401)
      expect(response.body).to eq "access_denied"
    end
  end

  describe "when sending the role and the role is not allowed to be sent" do
    it 'should not have role in the permitted_params' do
      post :create, params: { anonymou: { name: '123', email: 'a@at.com', role: 'admin' }}

      expect(response.status).to eq(200)
      expect(response.body).to include('email')
      expect(response.body).not_to include('role')
    end
  end

  describe "when deleting an open record" do
    it 'should grant access' do
      delete :destroy, params: { id: 'open' }

      expect(response.status).to eq(200)
      expect(response.body).to eq "Destroyed!"
    end
  end

  describe "when deleting an restricted record" do
    it 'should not grant access' do
      delete :destroy, params: { id: 'restricted' }

      expect(response.status).to eq(401)
      expect(response.body).to eq "access_denied"
    end
  end
end
