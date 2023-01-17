# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seeding for admin
User.create(first_name: "Usman", last_name: "Mazhar", email: "usmanjanjuaa3@gmail.com", password:
  "123456", password_confirmation: "123456", constituency:"167", cnic:"3740507754239", role:"admin")
User.create(first_name: "Admin", last_name: "Job", email: "admin@gmail.com", password:"123456",
    password_confirmation: "123456", constituency:"112", cnic:"3740507754238", role:"admin")

# Seeding for constituency
Constituency.create(id:167, name:"167")
Constituency.create(id:112, name:"112")
