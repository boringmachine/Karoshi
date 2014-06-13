web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb  
resque: bundle exec rake resque:work QUEUE='*'