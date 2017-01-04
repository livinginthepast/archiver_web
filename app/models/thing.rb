# == Schema Information
#
# Table name: things
#
#  id         :uuid             not null, primary key
#  profile_id :uuid             not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Thing < ApplicationRecord
  belongs_to :profile
  has_many :assets

end
