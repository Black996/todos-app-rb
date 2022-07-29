FactoryBot.define do
  factory :item do
    name { Faker::Name.unique.name}
    done {false}
    todo_id {nil}
  end
end