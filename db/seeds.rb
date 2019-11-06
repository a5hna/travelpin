# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# USERS
puts "destroying everything"
system "rails db:drop db:create db:migrate"
# db:drop
# db:create
# db:migrate
# Experience.destroy_all
# Board.destroy_all
# BoardUser.destroy_all
# Connection.destroy_all
# User.destroy_all
# Category.destroy_all

puts "Generating user seeds"
i = 1
10.times do
  puts "creating user #{i}"
  User.create!(
    name: "name#{i}",
    email: "email#{i}@lewagon.com",
    password: "password",
    avatar: "https://images.unsplash.com/photo-1520813792240-56fc4a3765a7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80")
  i += 1
end

@users = User.all

# CONNECTIONS

puts "Generating connection seeds"
x = 1
15.times do
  puts "creating connections: #{i}"
  Connection.create(
    user_one_id: @users.sample.id,
    user_two_id: @users.sample.id)
  x += 1
end

# BOARDS

puts "Generating board seeds"
i = 1
5.times do
  puts "creating board: #{i}"
  Board.create!(
    place: "board-place#{i}",
    title: "Board Title#{i}",
    longitude: "51.507351",
    latitude: "-0.127758")
  i += 1
end

@boards = Board.all

# BOARD_USERS
puts "Generating board_users and adding them to boards"
i = 1
@boards.each do |board|
  rand(1..5).times do
    puts "adding board_user to board: #{i}"
    BoardUser.create(
      board_id: board.id,
      user_id: @users.sample.id)
  end
    i += 1
end

# CATEGORIES
puts "Generating categories seeds"
Category.create!(name: "food")
Category.create!(name: "bars")
Category.create!(name: "outdoor activities")
Category.create!(name: "night life")
Category.create!(name: "watersports")
Category.create!(name: "sighseeing")
Category.create!(name: "shops/retail")
Category.create!(name: "museums")
Category.create!(name: "indoor activities")

@categories = Category.all



# EXPERIENCES

puts "Generating experiences and adding them to board"
i = 1
@boards.each do |board|
  "On board: #{i}"
  users = board.users
  users.each do |user|
    puts "creating experience for board: #{i}"
      3.times do
    Experience.create!(
      user_id: user.id,
      board_id: board.id,
      title: "Experience Title:#{i}",
      longitude: "51.507351",
      latitude: "-0.127758",
      photo: "https://images.unsplash.com/photo-1555400038-63f5ba517a47?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
      category_id: @categories.sample.id,
      vote: 0)
      end
  end
  i += 1
end





