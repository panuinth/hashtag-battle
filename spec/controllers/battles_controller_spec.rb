require 'spec_helper'


  def redis_client
    $redis = Redis.new(:host => Rails.application.config.redis_host, :port => Rails.application.config.redis_port, :password => Rails.application.config.redis_password, :thread_safe => true)
  end


  describe "CREATE battle" do

    it "should get hashtag from twitter streaming api" do
      
      #request.accept = "application/json"
      #get 'shorten', {:url => valid_attributes}, :format => :json
      #response_body = JSON.parse(response.body)
      #response_body['status_code'].should == 200
      #response_body['status_txt'].should == 'ok'
      #response_body['data'].should_not be_nil
    end


  end

  #describe "GET info" do

    #it "should get the site info from bitly api" do
      #request.accept = "application/json"
      #get 'info', {:url => valid_attributes}, :format => :json
      #response_body = JSON.parse(response.body)
      #response_body['status_code'].should == 200
      #response_body['status_txt'].should == 'ok'
      #response_body['data'].should_not be_nil
    #end

    #it "should not get site info if this url is invalid" do
      #request.accept = "application/json"
      #get 'info', {:url => invalid_attributes}, :format => :json
      #response_body = JSON.parse(response.body)
      #response_body['status_code'].should_not == 200
      #response_body['data'].should be_blank
    #end

  #end

  #describe "GET metric" do

    #it "should get the site metric from bitly api" do
      #request.accept = "application/json"
      #get 'metric', {:url => valid_attributes}, :format => :json
      #response_body = JSON.parse(response.body)
      #response_body['status_code'].should == 200
      #response_body['status_txt'].should == 'ok'
      #response_body['data'].should_not be_nil
    #end

    #it "should not get site metric if this url is invalid" do
      #request.accept = "application/json"
      #get 'metric', {:url => invalid_attributes}, :format => :json
      #response_body = JSON.parse(response.body)
      #response_body['status_code'].should_not == 200
      #response_body['data'].should be_blank
    #end

  

