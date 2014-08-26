class BattleHashtagsController < ApplicationController
  before_action :set_battle_hashtag, only: [:show, :edit, :update, :destroy]

  # GET /battle_hashtags
  # GET /battle_hashtags.json
  def index
    @battle_hashtags = BattleHashtag.all
  end

  # GET /battle_hashtags/1
  # GET /battle_hashtags/1.json
  def show
  end

  # GET /battle_hashtags/new
  def new
    @battle_hashtag = BattleHashtag.new
  end

  # GET /battle_hashtags/1/edit
  def edit
  end

  # POST /battle_hashtags
  # POST /battle_hashtags.json
  def create
    @battle_hashtag = BattleHashtag.new(battle_hashtag_params)

    respond_to do |format|
      if @battle_hashtag.save
        format.html { redirect_to @battle_hashtag, notice: 'Battle hashtag was successfully created.' }
        format.json { render :show, status: :created, location: @battle_hashtag }
      else
        format.html { render :new }
        format.json { render json: @battle_hashtag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /battle_hashtags/1
  # PATCH/PUT /battle_hashtags/1.json
  def update
    respond_to do |format|
      if @battle_hashtag.update(battle_hashtag_params)
        format.html { redirect_to @battle_hashtag, notice: 'Battle hashtag was successfully updated.' }
        format.json { render :show, status: :ok, location: @battle_hashtag }
      else
        format.html { render :edit }
        format.json { render json: @battle_hashtag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /battle_hashtags/1
  # DELETE /battle_hashtags/1.json
  def destroy
    @battle_hashtag.destroy
    respond_to do |format|
      format.html { redirect_to battle_hashtags_url, notice: 'Battle hashtag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle_hashtag
      @battle_hashtag = BattleHashtag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def battle_hashtag_params
      params.require(:battle_hashtag).permit(:hashtag_id, :battle_id)
    end
end
