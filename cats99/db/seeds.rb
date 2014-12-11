# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do
  user = User.create!(user_name: Faker::Internet.user_name, password: Faker::Internet.password(7))
  5.times do
    Cat.create!(birth_date: Faker::Date.between(60.days.ago, Date.yesterday),
                color: Cat::COLORS.sample, sex: Cat::SEXES.sample,
                description: Faker::Hacker.say_something_smart,
                name: Faker::Name.first_name, owner_id: user.id)
  end
end

user = User.create!(user_name: "Fante", password: "fantefante")

5.times do
  Cat.create!(birth_date: Faker::Date.between(60.days.ago, Date.yesterday),
              color: Cat::COLORS.sample, sex: Cat::SEXES.sample,
              description: Faker::Hacker.say_something_smart,
              name: Faker::Name.first_name, owner_id: user.id)
end

User.create!(user_name: "Picante", password: "picantepicante")
