10.times do
  name = Faker::Name.name
  address = Faker::Lorem.sentence
  age = Faker::Internet.email
  password = "123456"
  password_confirmation = "123456"
  User.create(name: name, address: address, email: age, password: password, password_confirmation: password_confirmation)

end
users = User.take(2)

3.times do
  name = Faker::Lorem.sentence
  users.each do |user|
    user.test_suits.create(name: name)
  end
end

test_suit = TestSuit.take

3.times do
  user = users.first
  name = Faker::Lorem.sentence
  test_suit.test_cases.create(name: name, user_id: user.id)
end

ActionType.create([
  {id: 1, name: "Web Test", description: ""},
  {id: 2, name: "Mobie Test", description: ""}
])
TestAction.create([
  {id: 1, name: "Click", action_type_id: "1"},
  {id: 2, name: "Write Text", action_type_id: "1"},
  {id: 3, name: "Go to Url", action_type_id: "1"},
  {id: 4, name: "Select Options", action_type_id: "1"},
])

Param.create([
  {id: 1, name: "Id", test_action_id: "1", param_value: ""},
  {id: 2, name: "Test Inside", test_action_id: "1", param_value: ""},
  {id: 3, name: "Name", test_action_id: "1", param_value: ""},
  {id: 4, name: "Class Name", test_action_id: "1", param_value: ""},
  {id: 5, name: "XPath", test_action_id: "1", param_value: ""},
  {id: 6, name: "Link Text", test_action_id: "1", param_value: ""},
  {id: 7, name: "CSS Selector", test_action_id: "1", param_value: ""}
])
