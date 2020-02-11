FactoryBot.define do
  factory :post do
    image { Rack::Test::UploadedFile.new(Rails.root.join('public/post_images/test.jpg')) }
    comment { 'exampleです' }
    fav_count { 0 }
    title { 'example' }
  end

  factory :other_post, class: Post do
    image { Rack::Test::UploadedFile.new(Rails.root.join('public/post_images/test.jpg')) }
    comment { 'other_exampleです' }
    fav_count { 3 }
    title { 'other_example' }
  end
end
