class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,:username, :password, :password_confirmation, :remember_me
  
  # attr_accessible :title, :body
  has_many :own_groups, :class_name => 'Group', :foreign_key => 'owner_id'
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :posts
  has_many :topics, through: :posts
end
