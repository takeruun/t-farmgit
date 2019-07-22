FactoryBot.define do
	factory :post do
		user_id {"2"}
		image {"2.jpg"}
		comment {"exampleです"}
		rec {true}
		title {"タイトル"}
	end
end