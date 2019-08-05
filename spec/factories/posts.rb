FactoryBot.define do
	factory :post do
		image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/post_images/1.jpg'))}
		comment {"exampleです"}
		fav_count {4}
		title {"example"}
	end

	factory :other_post, class: Post do
		image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/post_images/1.jpg'))}
		comment {"other_exampleです"}
		fav_count {3}
		title {"other_example"}
	end
end