FactoryBot.define do
	factory :user do
		  name {"パッポー"}
  		image_name {"example.jpg"}
  		email {"pa@example.com"}
  		password {"akeebUen"}
	end

	factory :user1, class: User do
		  name {"ほぐ"}
  		image_name {"example.jpg"}
  		email {"pa@example.com"}
  		password {"akeebUen"}
  	end
end