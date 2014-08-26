class BattleHashtag < ActiveRecord::Base
  belongs_to :hashtag
  belongs_to :battle
end
