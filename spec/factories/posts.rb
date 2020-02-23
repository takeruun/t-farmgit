FactoryBot.define do
  factory :post do
    image { Rack::Test::UploadedFile.new(Rails.root.join('public/post_images/test.jpg')) }
    a_word { 'exampleです' }
    fav_count { 0 }
    title { 'example' }
    from { '福岡県' }
  end

  factory :other_post, class: Post do
    image { Rack::Test::UploadedFile.new(Rails.root.join('public/post_images/test.jpg')) }
    a_word { 'other_exampleです' }
    fav_count { 3 }
    title { 'other_example' }
    from { '東京都' }
  end
end
