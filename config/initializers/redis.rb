#$redis = Redis.new(:host => Rails.application.config.redis_host, :port => Rails.application.config.redis_port, :password => Rails.application.config.redis_password, :thread_safe => true)

#heartbeat_thread = Thread.new do
  #while true
    #$redis.publish("heartbeat","thump")
    #sleep 30.seconds
  #end
#end

#at_exit do
  ## not sure this is needed, but just in case
  #heartbeat_thread.kill
  #$redis.quit
#end
