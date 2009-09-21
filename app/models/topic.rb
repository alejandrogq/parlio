# == Schema Information
# Schema version: 20090822155637
#
# Table name: topics
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Topic < ActiveRecord::Base
  seo_urls
  
  has_many :initiatives, :order => 'initiative_date desc'
  
  def self.most_active
    tuples = Initiative.count(:all, :group => "topic_id", :order => "count(*) DESC", :limit=> 6)
    returning ta = [] do
      tuples.each{|tuple| ta << Topic.find(tuple[0]) if tuple[0]}
    end
  end      
  
  def most_active_parliamentarians                         
    self.initiatives.with_parliamentarian.group_by(&:parliamentarian).sort_by{|x| x[1].size }.reverse.first(3)
  end
  
end
