# == Schema Information
#
# Table name: profiles
#
#  id         :uuid             not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Profile < ApplicationRecord
  has_many :omniauths
  has_many :things

end
