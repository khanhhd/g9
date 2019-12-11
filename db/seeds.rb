# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
TrackingSleep.delete_all
Relationship.delete_all

20.times do
  User.create(name: Faker::Name.name)
end

20.times do
  user = User.all.sample
  user.sleeping? ? user.wakeup : user.sleep
end

10.times do
  user = User.all.sample
  other_user = User.where.not(id: user.id).to_a.sample
  unless (user.following?(other_user) || other_user.following?(user))
    user.follow(other_user) unless user.following? other_user
  end
end
