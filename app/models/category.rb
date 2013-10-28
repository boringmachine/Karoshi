class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :groups
  
  def self.searchForGroup(group)
    if group.category != nil
      Category.find(group.category_id)
    else
      Category.new(name: "No Category")
    end
  end
end
