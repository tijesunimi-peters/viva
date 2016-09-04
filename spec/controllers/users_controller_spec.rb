require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:invalid_attributes) { attributes_for(
                                            :user,
                                            password_confirmation: "",
                                            email: ""
                                            )
                            }
  describe "#create" do
    context "when details validates" do
      it "creates user" do
        post :create, params: { user: attributes_for(:user) }
        expect(User.last.firstname).to eql("Dummy")
        expect(session["flash"]["flashes"]["success"]).
          to eql("Registration successful")
      end
    end

    context "when details does not validate" do
      it "returns error message" do
        post :create, params: { user: invalid_attributes }
        expect(session["flash"]["flashes"]["reg_errors"]).
          to include("Password confirmation doesn't match Password")
      end
    end
  end

  describe "#new" do
    it "return new user object" do
      get :new
      expect(assigns(:user)).to be_kind_of(User)
    end
  end
end
