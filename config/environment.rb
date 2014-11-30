# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Initialize the Services.
credentials = host = username = password = ''
if !ENV['VCAP_SERVICES'].blank?
  JSON.parse(ENV['VCAP_SERVICES']).each do |k,v|

    if !k.scan("sendgrid").blank?
      credentials = v.first.select {|k1,v1| k1 == "credentials"}["credentials"]
      host = credentials["hostname"]
      username = credentials["username"]
      password = credentials["password"]
    end
    
    if !k.scan("rediscloud").blank?
      credentials = v.first.select {|k1,v1| k1 == "credentials"}["credentials"]
      $redis = Redis.new(
        :host => credentials["hostname"],
        :port => credentials["port"], 
        :password => credentials["password"]
      )
    end
  end
end

if Rails.env.development?
  Resque.redis = 'localhost:6379'
else
  Resque.redis = $redis
end

ActionMailer::Base.smtp_settings = {
  :address        => host,
  :port           => '587',
  :authentication => :plain,
  :user_name      => username,
  :password       => password,
  :domain         => 'sendgrid.net',
  :enable_starttls_auto => true
}
