FactoryBot.define do
  factory :comment do
    user_id { nil }
    post_id { nil }
    content { 'comment example' }
  end

  factory :other_comment, class: Comment do
    user_id { nil }
    post_id { nil }
    content { 'other_comment example' }
  end
end
