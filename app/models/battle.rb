class Battle < ActiveRecord::Base
  has_many :hashtags, through: :battle_hashtags
  has_many :battle_hashtags

  def add_hashtags(hashtags_input)
    hashtags_input.each do |hashtag|
      if Hashtag.exists?(title: hashtag)
        existing_hashtag = Hashtag.where(title: hashtag).first
        hashtags << existing_hashtag
        save
      else
        hashtags.create(title: hashtag)
      end
    end
  end

  def hashtags_csv
    result = []
    hashtags.map(&:title).each do |hashtag|
      result << "%23#{hashtag}"
    end
    return result.join(",")
  end
end
