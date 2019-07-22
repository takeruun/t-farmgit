FactoryBot.define do
  factory :user do 
  		name {"パッポー"}
  		image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/user_images/i.jpg'))}
  		email {"a@example.com"}
  		password {"akeebUen"}
	end

	factory :user1, class: User do
		  name {"ほぐ"}
  		image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/user_images/i.jpg'))}
  		email {"b@example.com"}
  		password {"akeebUen"}
  	end
end
