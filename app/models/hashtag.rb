class Hashtag < ActiveRecord::Base
  has_many :battles, through: :battle_hashtags
  has_many :battle_hashtags

  def title_with_hashtag
    "##{title}"
  end

  def match_with_tweet?(tweet)
    #Check 3 cases
    #1. tweet with that hashtag
    #2. tweet without the hashtag
    #3. tweet with the hashtag that has any word character at the end
    tweet.downcase.include?(title_with_hashtag) and tweet.downcase.match(/[^#]#{title}/).nil? and tweet.downcase.match(/##{title}[\w]/).nil?
  end

end
