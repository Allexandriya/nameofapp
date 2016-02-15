require 'rails_helper'

describe Product do 
	context "when Product has comments"

	before do
		@product = Product.create!(name: "race bike")
		@user = User.create!(email: "john@gmail.com", password: "11111111")
		@product.comments.create!(rating: 1, user: @user, body: "Awful bike!")
		@product.comments.create!(rating: 3, user: @user, body: "nice!")
		@product.comments.create!(rating: 5, user: @user, body: "best!")
	end

	it "returns the average rating of all comments" do
		expect(@product.average_rating).to eq 3
	end

	context "When product hasnt name"
	it "is not valid" do
		expect(Product.new(description: "Nice bike")).not_to be_valid
	end

end