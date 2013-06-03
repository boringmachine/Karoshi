class Topic < ActiveRecord::Base
  attr_accessible :subject
  has_many :group_topic
  has_many :group, through: :group_topic
  has_many :post
  has_many :user , through: :post
  
end
