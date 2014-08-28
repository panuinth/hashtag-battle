require 'spec_helper'

describe Battle do

  def twitter_streaming_client
    @twitter_streaming_client ||= Twitter::Streaming::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_consumer_key
      config.consumer_secret     = Rails.application.config.twitter_consumer_secret
      config.access_token        = Rails.application.config.twitter_access_token
      config.access_token_secret = Rails.application.config.twitter_access_token_secret
    end
  end

  before(:each) do
    @valid_name = 'coffee vs tea'
    @valid_hashtags = ['coffee','tea']
    @invalid_name = nil
    @invalid_hashtags = "coffee tea"
    @test_battle = Battle.new(name: @valid_name)
    @test_battle.save
  end

  it 'should get the battle name' do
    expect(@test_battle).to be_valid
    expect(@test_battle.name).to match @valid_name
  end

  it 'should be valid if user put a valid battle name' do
    battle = Battle.new(name: @valid_name)
    expect(battle).to be_valid
  end

  it 'should not be valid if user put an invalid battle name' do
    battle = Battle.new(name: @invalid_name)
    expect(battle).not_to be_valid
  end

  it 'should get empty hashtags array after created battle' do
    battle = Battle.new(name: @valid_name)
    battle.save
    expect(battle.hashtags).to be_blank
  end

  it 'should get hashtags array after assigned hashtag' do
    @test_battle.add_hashtags(@valid_hashtags)
    expect(@test_battle.hashtags.map(&:title)).to match_array(['coffee','tea'])
  end

  it 'should not get hashtags array after assigned invalid hashtag' do
    expect(@test_battle.add_hashtags(@invalid_hashtags)).to be false
  end

  #Twitter streaming API
  it 'should get tweet that contain #coffee' do
    @battle = Battle.create(name: "coffee")
    @battle.add_hashtags(["coffee"])

    twitter_streaming_client.filter(:track => @battle.hashtags_csv) do |object|
      #Check if it's a tweet object
      if object.is_a?(Twitter::Tweet)
        expect(object.text.downcase.include? "#coffee").to be true
        break
      end
    end
  end

  it 'should not get tweet that contain coffee without hashtag' do
    @battle = Battle.create(name: "coffee")
    @battle.add_hashtags(["coffee"])
    #Sometime twitter has too many connection. Have to delay 5 secs before reconnecting
    sleep 5

    twitter_streaming_client.filter(:track => @battle.hashtags_csv) do |object|
      #Check if it's a tweet object
      if object.is_a?(Twitter::Tweet)
        expect(object.text.downcase.match(/[^#]coffee/)).to be nil
        break
      end
    end
  end

  it 'should not get tweet that contain #coffeebuddy' do
    @battle = Battle.create(name: "coffeebuddy")
    @battle.add_hashtags(["coffeebuddy"])
    #Sometime twitter has too many connection. Have to delay 5 secs before reconnecting
    sleep 5

    twitter_streaming_client.filter(:track => @battle.hashtags_csv) do |object|
      #Check if it's a tweet object
      if object.is_a?(Twitter::Tweet)
        expect(object.text.downcase.match(/#coffee[\w]/)).to be nil
        break
      end
    end
  end

end


