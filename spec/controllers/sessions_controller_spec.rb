require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  before do
    create :user
  end

  describe "#create" do
    let(:login_input) { { email: "dummy@dummy.com", password: "password" } }

    context "when input is correct" do
      it "sets the session" do
        post :create, params: login_input
        expect(session[:user_id]).to eql(1)
        expect(session["flash"]["flashes"]["success"]).
          to eql("Login Successful")
      end
    end

    context "when login params is nil" do
      it "flashes error message" do
        post :create
        expect(session["flash"]["flashes"]["errors"]).
          to eql("Email/Password Incorrect")
      end
    end

    context "when there is return route" do
      it "redirects to return route" do
        session[:return_route] = "http://localhost:3001"
        post :create, params: login_input
        expect(response).to redirect_to("http://localhost:3001")
      end
    end

    describe "#logout" do
      context "when user logs out" do
        it "flashes session logout successful" do
          post :create, params: login_input
          get :logout
          expect(session[:user_id]).to be_nil
          expect(session["flash"]["flashes"]["success"]).
            to eql("Logout Successful")
        end
      end
    end
  end
end
