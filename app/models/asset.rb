# == Schema Information
#
# Table name: assets
#
#  id         :uuid             not null, primary key
#  thing_id   :uuid             not null
#  path       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#

class Asset < ApplicationRecord
  belongs_to :thing
end
