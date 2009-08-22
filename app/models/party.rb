# == Schema Information
# Schema version: 20090822155637
#
# Table name: parties
#
#  id         :integer         not null, primary key
#  group_name :string(255)
#  acronym    :string(255)
#  sites      :string(255)
#  name       :string(255)
#  url        :string(255)
#  logo       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Party < ActiveRecord::Base
  has_many :parliamentarians
end
