# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create!(
  email: 'manuroy169@gmail.com',
  password: 'xpose009@',
  password_confirmation: 'Xpose009@',
  admin: true,
)
User.create!(
  email:"orgatro.it.official@gmail.com',
  password: 'orgatro009@',
  password_confirmation: 'orgatro009@',
  admin: true,
)
