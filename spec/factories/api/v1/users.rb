FactoryGirl.define do
  factory :user do
    firstname "Dummy"
    lastname "Dummy"
    email "dummy@dummy.com"
    password "password"
    password_confirmation "password"
  end
end
