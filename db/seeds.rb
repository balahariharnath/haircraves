# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

roles = [{role_name: "customer"}, {role_name: "business_owner"}, {role_name: "stylist"}]

roles.each do |role|
  Role.where(role_name: role[:role_name]).first_or_create
end
