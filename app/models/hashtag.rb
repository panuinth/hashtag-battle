class Hashtag < ActiveRecord::Base
  has_many :battles, through: :battle_hashtags
  has_many :battle_hashtags

end
