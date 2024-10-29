# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'httparty'
require 'faker'

API_URL = "https://dog.ceo/api/breeds/list/all"

Dog.destroy_all
Breed.destroy_all


response = HTTParty.get(API_URL)
breeds = response.parsed_response['message'].keys

breeds.each do |breed_name|
  breed = Breed.create(name: breed_name)
  puts "Attempting to create breed: #{breed_name}"
  if breed.persisted?
    puts "Created breed: #{breed.name}"
  else
    puts "Failed to create breed: #{breed.errors.full_messages.join(", ")}"
  end
end
puts "#{breeds.count} breeds added to the database."



if Breed.any?
  100.times do
    breed_id = Breed.pluck(:id).sample
    dog = Dog.create(
      name: Faker::Creature::Dog.name,
      age: rand(1..15),
      breed_id: breed_id  # Ensure this ID exists
    )
    
    unless dog.persisted?
      puts "Failed to create dog: #{dog.errors.full_messages.join(", ")}"
    end
  end
else
  puts "No breeds available to assign to dogs."
end

5.times do
  owner = Owner.create(name: Faker::Name.name, age: rand(20..70))
  # Randomly assign some dogs to this owner by grabbign 1 or 2 dogs 
  dogs_to_assign = Dog.order('RANDOM()').limit(rand(1..3)) # Select 1 to 3 random dogs through some random sql query stuff
  owner.dogs << dogs_to_assign
end
