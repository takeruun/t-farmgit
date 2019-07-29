FactoryBot.define do
	factory :post do
		user_id {2}
		image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/post_images/1.jpg'))}
		comment {"exampleです"}
		fav_count {4}
		title {"example"}
	end
end