FactoryGirl.define do
	sequence(:email) { |n| "user#{n}@example.com" }
	factory :user do
		email 
		password "helloworld"
		first_name "john"
		last_name "Doe"
		admin false
		password_confirmation "helloworld"
	end

	sequence(:name) { |n| "Test product # #{n}" }
	factory :product do
		name
	end
end