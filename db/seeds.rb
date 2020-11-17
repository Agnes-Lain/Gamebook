.# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Destroying...␥'
User.destroy_all
UserGame.destroy_all
UserConsole.destroy_all

puts '>>Loading...🚃'

user1 = User.create(
  email:"test_user1@test.com",
  password: "test_user1@test.com",
  user_name: "user1"
)

image1 = URI.open("https://avatars1.githubusercontent.com/u/60975663?s=460&u=0fa7727e6fb40e7f9567fadcb43f2b7452d87c91&v=4")
user1.photo.attach(io: image1, filename: "user#{user1.id}.jpg", content_type: "image/png")

user2 = User.create(
  email:"test_user2@test.com",
  password: "test_user2@test.com",
  user_name: "user2"
)

image2 = URI.open("https://avatars3.githubusercontent.com/u/64773479?v=4")
user2.photo.attach(io: image2, filename: "user#{user2.id}.png", content_type: "image/png")

game1 = Game.create(
  title: "Mario kart 8",
  rawg_id: 27976
)

game2 = Game.create(
  title: "The Legend of Zelda: A Link Between Worlds",
  rawg_id: 27977
)
