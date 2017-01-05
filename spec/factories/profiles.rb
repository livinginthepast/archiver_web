# == Schema Information
#
# Table name: profiles
#
#  id         :uuid             not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :profile do
    username { Faker::Name.last_name.downcase }
  end
end
