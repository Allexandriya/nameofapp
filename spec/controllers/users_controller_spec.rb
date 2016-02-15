require "rails_helper"

describe UsersController, :type => :controller do
	before do
		@user = User.create!(first_name: "matt", last_name: "mattie", email: "123@gmail.com", password: "12345678")
	end

	describe "GET #show" do
		context "User is logged in" do
			before do
				sign_in @user
			end

			it "loads correct user details" do
				get :show
				expect(response).to redirect_to(root_path)
			end
		end

		context "No user is logged in" do
			it "redirects to index" do
				get :show, id: @user.id
				expect(response).to redirect_to(root_path)
			end
		end
	end
end