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
i = 1
45.times do
  puts "creating connections: #{i}"
  Connection.create(
    user_one_id: @users.sample.id,
    user_two_id: @users.sample.id)
  i += 1
end

# BOARDS

puts "Generating board seeds"
i = 1
10.times do
  puts "creating board: #{i}"
  Board.create!(
    place: ["London", "Beijing", "Singapore", "Paris", "Bali"].sample,
    title: "Board Title#{i}",
    )
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
      1.times do
        exp = Experience.new(
          user_id: user.id,
          board_id: board.id,
          title: "Rice Paddies:#{i}",
          photo: "https://images.unsplash.com/photo-1555400038-63f5ba517a47?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
          category_id: @categories.sample.id,
          vote: 0)
          exp.latitude = rand((exp.board.latitude.to_f - 0.05)..(exp.board.latitude.to_f + 0.05))
          exp.longitude = rand((exp.board.longitude.to_f - 0.05)..(exp.board.longitude.to_f + 0.05))
          exp.save!

        exp2 = Experience.new(
          user_id: user.id,
          board_id: board.id,
          title: "Swing:#{i}",
          photo: "https://images.unsplash.com/photo-1554481923-a6918bd997bc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=802&q=80",
          category_id: @categories.sample.id,
          vote: 0)
          exp2.latitude = rand((exp2.board.latitude.to_f - 0.05)..(exp2.board.latitude.to_f + 0.05))
          exp2.longitude = rand((exp2.board.longitude.to_f - 0.05)..(exp2.board.longitude.to_f + 0.05))
          exp2.save!

        exp3 = Experience.new(
          user_id: user.id,
          board_id: board.id,
          title: "Monkey Forest:#{i}",
          photo: "https://images.unsplash.com/photo-1536146021566-627ce3c4d813?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
          category_id: @categories.sample.id,
          vote: 0)
          exp3.latitude = rand((exp3.board.latitude.to_f - 0.05)..(exp3.board.latitude.to_f + 0.05))
          exp3.longitude = rand((exp3.board.longitude.to_f - 0.05)..(exp3.board.longitude.to_f + 0.05))
          exp3.save!

        exp4 = Experience.new(
          user_id: user.id,
          board_id: board.id,
          title: "Floating Breakfast:#{i}",
          photo: "https://images.unsplash.com/photo-1543668900-9124915a121f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
          category_id: @categories.sample.id,
          vote: 0)
          exp4.latitude = rand((exp4.board.latitude.to_f - 0.05)..(exp4.board.latitude.to_f + 0.05))
          exp4.longitude = rand((exp4.board.longitude.to_f - 0.05)..(exp4.board.longitude.to_f + 0.05))
          exp3.save!
      end
  end
  i += 1
end





