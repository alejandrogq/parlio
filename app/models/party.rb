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
  seo_urls
  has_many :parliamentarians  
  
  def initiatives
    self.parliamentarians.collect{|p| p.initiatives}.flatten.uniq
  end
  
  def interventions
    self.parliamentarians.collect{|p| p.interventions}.flatten.uniq
  end
  
  def self.most_active
    tuples = Initiative.count(:all, :group => "party_id", :include => [:parliamentarian], :order => "count(*) DESC")
    returning most_active = [] do
      tuples.each{|tuple| most_active << [Party.find(tuple[0]), tuple[1]]}
    end
  end
  def party_acronym
    /\((.*)\)/.match(self.name)[1]  rescue nil
  end
end
