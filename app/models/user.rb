class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,:username, :password, :password_confirmation, :remember_me, :locale_id,
                  :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at

  has_attached_file :photo, :styles => { :small => "48x48#", :medium => "160x160#" },
    :storage => :s3,
    :bucket => 'rocky-wave-100',
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :default_url => "/photos/verysmall/missing.png"
    
  validates :username, :length => (1..20)
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png','image/gif']
  
  
  # attr_accessible :title, :body
  has_many :own_groups, :class_name => 'Group', :foreign_key => 'owner_id'
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :posts
  has_many :topics, through: :posts
  belongs_to :locale
  
end
