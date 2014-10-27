#if Rails.env.development?
#  Resque.redis = 'localhost:6379'
#else
#  Resque.redis = ENV['REDISTOGO_URL']
#end