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
  10.times do
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


