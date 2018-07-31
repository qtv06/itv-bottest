10.times do
  name = Faker::Name.name
  address = Faker::Lorem.sentence
  age = Faker::Internet.email
  password = "123456"
  password_confirmation = "123456"
  User.create(name: name, address: address, email: age, password: password, password_confirmation: password_confirmation)

  users = User.take(3)

  3.times do
    name = Faker::Lorem.sentence
    users.each do |user|
      user.test_suits.create(name: name)
    end
  end
end
