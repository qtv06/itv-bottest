10.times do
  name = Faker::Name.name
  address = Faker::Lorem.sentence
  age = Faker::Number.number(2)

  User.create(name: name, address: address, age: age)

  users = User.take(3)

  3.times do
    name = Faker::Lorem.sentence
    users.each do |user|
      user.test_suits.create(name: name)
    end
  end
end
