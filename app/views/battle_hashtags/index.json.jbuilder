json.array!(@battle_hashtags) do |battle_hashtag|
  json.extract! battle_hashtag, :id, :hashtag_id, :battle_id
  json.url battle_hashtag_url(battle_hashtag, format: :json)
end
