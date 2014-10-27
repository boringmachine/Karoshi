# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Locale.count == 0
  Locale.create({:name => 'en'})
  Locale.create({:name => 'ja'})
end

if Community.count == 0 
  community = Community.create(name:"Global Community", description: "")
  topic = Topic.getFirstTopic
  topic.community_id = community.id
  topic.save
end