FactoryGirl.define do
  factory :user do
    name                  "Dylan Teste"
    email                 "djmgguedes@teste.com"
    login                 "djmgguedes"
    password              "test123"
    password_confirmation "test123"
  end

  factory :section do
    name                  "an idiot section"
    description           "a stupid description"
  end
end