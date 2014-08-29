class BattlesController < ApplicationController
  include ActionController::Live

  before_action :set_battle, only: [:show, :edit, :update, :destroy]

  # GET /battles
  # GET /battles.json
  def index
    @battles = Battle.all
  end

  # GET /battles/1
  # GET /battles/1.json
  def show
  end

  # GET /battles/new
  def new
    @battle = Battle.new
  end

  # GET /battles/1/edit
  def edit
  end

  # POST /battles
  # POST /battles.json
  def create
    #Convert comma seprated value into an array
    hashtags = battle_params[:hashtags].split(',')
    @battle = Battle.new(name: battle_params[:name])
    if @battle.save

      #Insert hashtags into the battle
      @battle.add_hashtags(hashtags)

      $redis = Redis.new(:host => Rails.application.config.redis_host, :port => Rails.application.config.redis_port, :password => Rails.application.config.redis_password, :thread_safe => true)

      #Pull data from twitter streaming api
      begin
        end_time = (Time.now + 5.minutes)

        @battle.hashtags.each do |battle_ht|
          data = {:keyword => "#{battle_ht.title.downcase}", :end_time => end_time }
          $redis.publish("battle:hashtag:#{@battle.id}", data.to_json )
          sleep 1
        end

        TweetStream::Client.new.track(@battle.hashtags_csv) do |object, client|

          if object.hashtags?
            object.hashtags.each do |ht|
              @battle.hashtags.each do |battle_hashtag|
                if battle_hashtag.title.downcase == ht.text.downcase

                  data = {:keyword => ht.text.downcase, :end_time => end_time }

                  #Check time left
                  if Time.now > end_time
                    logger.info "Time's up"
                    client.stop
                    $redis.quit
                    break
                  else
                    $redis.publish("battle:hashtag:#{@battle.id}", data.to_json )
                    sleep 1
                  end

                end
              end
            end
          end
        end


      rescue => error
        logger.info "#{error}"
        #render :json => {:status=> "error", :message => "#{error}" }, :status=>500
        #return
      ensure
        #logger.info "Stopping twitter stream"
        #$redis.quit
      end
      render :json => {:status=>"success", :message => "done"}, :status=>200
    else
      render :json => {:status=> :unprocessable_entity, :error => @battle.errors }, :status=>422
    end

  end

  # PATCH/PUT /battles/1
  # PATCH/PUT /battles/1.json
  def update
    respond_to do |format|
      if @battle.update(battle_params)
        format.html { redirect_to @battle, notice: 'Battle was successfully updated.' }
        format.json { render :show, status: :ok, location: @battle }
      else
        format.html { render :edit }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /battles/1
  # DELETE /battles/1.json
  def destroy
    @battle.destroy
    respond_to do |format|
      format.html { redirect_to battles_url, notice: 'Battle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"

    $redis = Redis.new(:host => Rails.application.config.redis_host, :port => Rails.application.config.redis_port, :password => Rails.application.config.redis_password, :thread_safe => true)
    logger.info "New stream starting, connecting to redis"

    #ticker = Thread.new { loop { response.stream.write "hearbeat"; sleep 5 } }
    #sender = Thread.new do
      $redis.psubscribe("battle:hashtag:*") do |on|
        on.pmessage do |pattern, event, data|

          response.stream.write("event: #{event}\n")
          response.stream.write("data: #{data}\n\n")


          #if event == 'heartbeat'
            #response.stream.write("event: heartbeat\ndata: heartbeat\n\n")
          #else
            #response.stream.write("event: #{event}\n")
            #response.stream.write("data: #{data}\n\n")
          #end

          sleep 0.0001 # HACK: Prevent server instance from sleeping forever if client disconnects
        end
      end
    #end
    #ticker.join
    #sender.join
  rescue IOError
    logger.info "Stream closed"
  ensure
    logger.info "Stopping stream thread"
    #Thread.kill(ticker) if ticker
    #Thread.kill(sender) if sender
    $redis.quit
    response.stream.close
  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_battle
    @battle = Battle.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def battle_params
    params.require(:battle).permit(:name,:hashtags)
  end
end
