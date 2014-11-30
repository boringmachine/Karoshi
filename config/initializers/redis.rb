#rediscloud_service = JSON.parse(ENV['VCAP_SERVICES'])["rediscloud-null"]
#credentials = rediscloud_service.first["credentials"]
#$redis = Redis.new(:host => credentials.hostname, :port => credentials.port, :password => credentials.password)


#if Rails.env.development?
#  Resque.redis = 'localhost:6379'
#else
#  Resque.redis = credentials.hostname + ":" + credentials.port
#end