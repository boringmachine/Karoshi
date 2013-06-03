class Topic < ActiveRecord::Base
  attr_accessible :subject
  has_many :group_topics
  has_many :groups, through: :group_topics
 
end
