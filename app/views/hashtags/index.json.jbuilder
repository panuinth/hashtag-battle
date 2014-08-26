json.array!(@hashtags) do |hashtag|
  json.extract! hashtag, :id, :title, :battle_id
  json.url hashtag_url(hashtag, format: :json)
end
