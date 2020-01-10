FactoryBot.define do
  factory :comment do
    user { nil }
    post { nil }
    content { "example" }
  end
end
