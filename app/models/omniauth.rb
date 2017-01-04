# == Schema Information
#
# Table name: omniauths
#
#  id         :uuid             not null, primary key
#  profile_id :uuid             not null
#  uid        :string           not null
#  email      :string           not null
#  name       :string           not null
#  provider   :enum             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Omniauth < ApplicationRecord
  belongs_to :profile

  before_validation :ensure_profile

  enum provider: {
    google: 'google',
    developer: 'developer'
  }

  def ensure_profile
    self.profile ||= Profile.create(username: self.email.split('@').first.downcase)
  end
end
