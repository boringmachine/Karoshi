json.array!(@community_users) do |community_user|
  json.extract! community_user, :id, :user_id, :community_id
  json.url community_user_url(community_user, format: :json)
end
