FactoryBot.define do
	factory :post do
		image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/post_images/1.jpg'))}
		comment {"exampleです"}
		title {"example"}
	end

	factory :other_post, class: Post do
		image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/post_images/1.jpg'))}
		comment {"other_exampleです"}
		title {"other_example"}
	end
end