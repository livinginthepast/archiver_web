FactoryGirl.define do
  factory :profile do
    username { Faker::Name.last_name.downcase }
  end
end
