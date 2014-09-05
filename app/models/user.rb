class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :timeoutable

  # Setup accessible (or protected) attributes for your model

  has_attached_file :photo, :styles => { :small => "48x48#", :medium => "160x160#" },
    :storage => :s3,
    :bucket => 'rocky-wave-100',
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :default_url => "/photos/verysmall/missing.png"
    
  validates :username, :length => (1..20), :presence => true 
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png','image/gif']
  validates :email, :presence => true 
  
  # attr_accessible :title, :body
  has_many :own_groups, :class_name => 'Group', :foreign_key => 'owner_id'
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :posts
  has_many :topics, through: :posts
  belongs_to :locale
  
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(username: auth.info.nickname,
                         provider: auth.provider,
                         uid:      auth.uid,
                         email:    User.create_unique_email,
                         password: Devise.friendly_token[0,20],
                         authentication_token: create_unique_string
                        )
    end
    User.join_first_group(user)
    user
  end
 
  def self.create_unique_string
    SecureRandom.uuid
  end
 
  def self.create_unique_email
    email = loop do
      tmp = SecureRandom.urlsafe_base64(nil, false)
      break tmp unless User.exists?(email: tmp+"@karoshi.heroku.com")
    end
    email + "@karoshi.heroku.com"
  end
  
  def self.join_first_group(user)
    if Group.first == nil
      group = Group.create(name:"Global Group")
      topic = Topic.getFirstTopic
      GroupTopic.create(group_id:group.id,topic_id:topic.id)
    end
    unless user.id.blank?
      group = Group.first
      GroupUser.create(user_id: user.id, group_id: group.id)
    end
  end
  
 
end
