class Group < ActiveRecord::Base
  attr_accessible :category_id, :description, :email, :name, :url, :visible
  has_one :category
end
