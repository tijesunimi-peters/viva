FactoryGirl.define do
  factory :login_input, class: SessionsController do
    email 'dummy@dummy.com'
    password 'password'
  end
end