User.create!(name:  "Admin",
             email: "admin@gmail.com",
             password:              "123123",
             password_confirmation: "123123",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Hieu",
             email: "hieu@gmail.com",
             password:              "123123",
             password_confirmation: "123123",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

20.times do |n|
  title = Faker::Name.name
  describe = Faker::Lorem.sentence(5)
  Category.create!(title:  title,
                  describe: describe)
end

99.times do |n|
  name = Faker::Name.name
  describe = Faker::Lorem.sentence(5)
  Artist.create!(name:  name,
                 describe: describe)
end

99.times do |n|
  name = Faker::Name.name
  describe = Faker::Lorem.sentence(5)
  Album.create!(name:  name,
                describe: describe,
                artist_id: 99/(n +1))
end
