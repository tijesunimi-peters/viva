require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#create' do
    context "when details validates" do
      it 'creates user' do
        post :create, params: { user: attributes_for(:user) }
        expect(User.last.firstname).to eql('Dummy')
        expect(session["flash"]["flashes"]["success"]).
          to eql("Registration Successful")
      end
    end

    context 'when details does not validate' do
      it 'returns error message' do
        details = attributes_for(:user, password_confirmation: "", email: "" )
        post :create, params: { user: details }
        expect(session["flash"]["flashes"]["errors"]).
          to include("Password confirmation doesn't match Password<br>")
      end
    end
  end

  describe '#new' do
    it 'return new user object' do
      get :new
      expect(assigns(:user)).to be_kind_of(User)
    end
  end
end
