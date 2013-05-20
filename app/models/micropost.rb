class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  
  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :content, :presence => true
  
  default_scope :order => 'microposts.created_at DESC'
end
