json.array!(@topics) do |topic|
  json.extract! topic, :id, :community_user_id
  json.url topic_url(topic, format: :json)
end
