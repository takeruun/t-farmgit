FactoryBot.define do
  factory :user do 
  		name {"user"}
  		image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/user_images/test.jpg'))}
  		email {"a@example.com"}
  		password {"akeebUen"}
	end

	factory :other_user, class: User do
		  name {"other_user"}
  		image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/user_images/test.jpg'))}
  		email {"b@example.com"}
  		password {"akeebUen"}
  	end
end
