class Group < ActiveRecord::Base
  attr_accessible :address, :category_id, :description, :geo, :name, :tel, :url
  belongs_to :category
  has_many :group_topic
  has_many :group_user
  has_many :topic, through: :group_topic
  has_many :user , through: :group_user
end
