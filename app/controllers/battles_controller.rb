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
      twitter_streaming_client.filter(:track => @battle.hashtags_csv) do |object|
        #Check if it's a tweet object
        if object.is_a?(Twitter::Tweet)
          keywords = []
          #Iterate hashtags to check if any tweet match
          @battle.hashtags.each do |hashtag|
            #Assign to keyword if match
            if hashtag.match_with_tweet?(object.text)
              keywords << hashtag.title
            end
          end
          data = {:tweet => "#{object.text}", :total_hashtag => @battle.hashtags.count, :keywords => keywords }
          $redis.publish("battle:hashtag:#{@battle.id}", data.to_json ) if keywords.count > 0
        end
      end
    render :json => {:status=>"success"}, :status=>200
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

    $redis.psubscribe("battle:hashtag:*") do |on|
      on.pmessage do |pattern, event, data|
        response.stream.write("event: #{event}\n")
        response.stream.write("data: #{data}\n\n")
        sleep 0.0001 # HACK: Prevent server instance from sleeping forever if client disconnects
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
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
