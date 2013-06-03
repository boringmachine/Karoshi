class Group < ActiveRecord::Base
  attr_accessible :address, :category_id, :description, :geo, :name, :tel, :url, :visible
  belongs_to :category
  has_many :group_topics
  has_many :group_users
  has_many :topics, through: :group_topics
  has_many :users , through: :group_users
end
