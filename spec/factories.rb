FactoryGirl.define do
  factory :user do
    name                  "forbiddenuser"
    email                 "forbiddenuser@teste.com"
    login                 "forbiddenuser"
    password              "forbidden"
    password_confirmation "forbidden"
  end

  factory :section do
    name                  "an idiot section"
    description           "a stupid description"
  end

  factory :post do
    content               "random content"  
  end

  factory :topic do
    title                 "random title"
    subtitle              "random subtitle"
    content               "randomcontent"
  end

  factory :report_topic do
    description           "a description"*10
    type                  "ReportTopic"
  end

  factory :report_post do
    description           "a descriptionvfasfvasfsavvfasvfsaf"*2
    type                  "ReportPost"
  end

  factory :report do
    description           "a dadsuadhasodahodiaushdasdhusauidhasd"*2
  end
end