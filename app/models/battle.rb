class Battle < ActiveRecord::Base
  has_many :hashtags, through: :battle_hashtags
  has_many :battle_hashtags

  validates :name, :presence => true

  def add_hashtags(hashtags_input)
    return false if not hashtags_input.class.eql?(Array)
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
    return hashtags.map(&:title).join(",")
  end
end
