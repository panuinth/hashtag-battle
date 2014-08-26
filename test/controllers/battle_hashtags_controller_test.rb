require 'test_helper'

class BattleHashtagsControllerTest < ActionController::TestCase
  setup do
    @battle_hashtag = battle_hashtags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:battle_hashtags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create battle_hashtag" do
    assert_difference('BattleHashtag.count') do
      post :create, battle_hashtag: { battle_id: @battle_hashtag.battle_id, hashtag_id: @battle_hashtag.hashtag_id }
    end

    assert_redirected_to battle_hashtag_path(assigns(:battle_hashtag))
  end

  test "should show battle_hashtag" do
    get :show, id: @battle_hashtag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @battle_hashtag
    assert_response :success
  end

  test "should update battle_hashtag" do
    patch :update, id: @battle_hashtag, battle_hashtag: { battle_id: @battle_hashtag.battle_id, hashtag_id: @battle_hashtag.hashtag_id }
    assert_redirected_to battle_hashtag_path(assigns(:battle_hashtag))
  end

  test "should destroy battle_hashtag" do
    assert_difference('BattleHashtag.count', -1) do
      delete :destroy, id: @battle_hashtag
    end

    assert_redirected_to battle_hashtags_path
  end
end
