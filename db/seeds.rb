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
API_URL = "https://dog.ceo/api/breeds/list/all"

Breed.destroy_all


response = HTTParty.get(API_URL)
breeds = response.parsed_response['message'].keys

breeds.each do |breed_name|
    Breed.create(name: breed_name)
  end
puts "#{breeds.count} breeds added to the database."


