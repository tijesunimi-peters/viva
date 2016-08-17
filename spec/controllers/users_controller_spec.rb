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
  end
end
