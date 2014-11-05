json.array!(@posts) do |post|
  json.extract! post, :id, :topic_id, :community_user_id
  json.url post_url(post, format: :json)
end
