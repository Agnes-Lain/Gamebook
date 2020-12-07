# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# puts 'Destroying...␥'
# UserGameUserPlatform.destroy_all
# UserGame.destroy_all
# UserPlatform.destroy_all
# User.destroy_all

puts '>>Loading...🚃'

puts "create users..."
# user1 = User.create(
#   email:"test_user1@test.com",
#   password: "test_user1@test.com",
#   user_name: "user1"
# )

# image1 = URI.open("https://avatars1.githubusercontent.com/u/60975663?s=460&u=0fa7727e6fb40e7f9567fadcb43f2b7452d87c91&v=4")
# user1.photo.attach(io: image1, filename: "user#{user1.id}.jpg", content_type: "image/png")

# puts "user1 created"

# user2 = User.create(
#   email:"test_user2@test.com",
#   password: "test_user2@test.com",
#   user_name: "user2"
# )

# image2 = URI.open("https://avatars3.githubusercontent.com/u/64773479?v=4")
# user2.photo.attach(io: image2, filename: "user#{user2.id}.png", content_type: "image/png")

# puts "user2 created"


user3 = User.create(
  email:"test_user3@test.com",
  password: "test_user3@test.com",
  user_name: "user3"
)

image3 = URI.open("https://image.shutterstock.com/image-vector/gamer-mascot-geek-boy-logo-260nw-1388054954.jpg")
user3.photo.attach(io: image3, filename: "user#{user3.id}.png", content_type: "image/png")

puts "user3 created"

user4 = User.create(
  email:"test_user4@test.com",
  password: "test_user4@test.com",
  user_name: "user4"
)

image4 = URI.open("https://image.freepik.com/free-vector/gamer-youtuber-gaming-avatar-with-headphones-esport-logo_8169-260.jpg")
user4.photo.attach(io: image4, filename: "user#{user4.id}.png", content_type: "image/png")

puts "user4 created"


user5 = User.create(
  email:"test_user5@test.com",
  password: "test_user5@test.com",
  user_name: "user5"
)

image5 = URI.open("https://mir-s3-cdn-cf.behance.net/project_modules/disp/a7734729386097.55f0774c5721a.png")
user5.photo.attach(io: image5, filename: "user#{user5.id}.png", content_type: "image/png")

puts "user5 created"

user6 = User.create(
  email:"test_user6@test.com",
  password: "test_user6@test.com",
  user_name: "user6"
)

image6 = URI.open("https://mir-s3-cdn-cf.behance.net/project_modules/disp/c4b10929386097.55f0774c56281.png")
user6.photo.attach(io: image6, filename: "user#{user6.id}.png", content_type: "image/png")

puts "user6 created"

user7 = User.create(
  email:"test_user7@test.com",
  password: "test_user7@test.com",
  user_name: "user7"
)

image7 = URI.open("https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/ea72e145858767.584019f61847c.png")
user7.photo.attach(io: image7, filename: "user#{user7.id}.png", content_type: "image/png")

puts "user7 created"


# puts "adding all available consoles from rawg 🕹"
# console_nil = Console.create(console_model:"Choose a platform",rawg_id: 0)
# consoles_list = HTTParty.get("https://api.rawg.io/api/platforms?ordering=id")["results"]
# consoles_list2 = HTTParty.get("https://api.rawg.io/api/platforms?ordering=id&page=2")["results"]
# consoles = console_nil + consoles_list + consoles_list2
# consoles.each do |console|
#   Console.create(
#     console_model: console['name'],
#     release_year: console["year_start"].to_i,
#     rawg_id: console['id']
#     )
# end

# puts "user_platforms create..."
# user1_platform1 = UserPlatform.create(user_id:user1.id, rawg_platform_id: 18, rating: 4, comments: "I don't really like the touch of controller, but fine, it runs fast")
# user1_platform2 = UserPlatform.create(user_id:user1.id, rawg_platform_id: 4, rating: 2, comments: "my pc is too old, slow")
# user2_platform1 = UserPlatform.create(user_id:user2.id, rawg_platform_id: 18, rating: 5, comments: "I love platstations!")
# puts "user_platforms created!"

# puts "user_games create..."
# user1_game1 = UserGame.create(user_id:user1.id, rawg_game_id: 50677 , rating: 4, comments: "Such a nice game")
# user2_game1 = UserGame.create(user_id:user2.id, rawg_game_id: 50677, rating: 5, comments: "love it")
# puts "user_games created!"

