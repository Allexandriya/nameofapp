require "rails_helper"

describe RegistrationsController, :type => :controller do
	before do
		@user = FactoryGirl.create(:user)
		@user1 = FactoryGirl.create(:user)
	end

	describe "GET #edit" do
		context "User is logged in" do
			before do
				sign_in @user
			end

			it "loads correct user details" do
				@request.env["devise.mapping"] = Devise.mappings[:user]
				get :edit
				expect(response).to be_success
				expect(response).to have_http_status(200)
				expect(assigns(:user)).to eq @user
			end
		end

		context "No user is logged in" do
				it "redirects to login" do
					@request.env["devise.mapping"] = Devise.mappings[:user]
					get :edit, id: @user.id
					expect(response).to redirect_to(user_session_path)
				end
		end

		context "Cannot access other user edit" do
			before do
				sign_in @user
			end

			it "redirects to login" do
				@request.env["devise.mapping"] = Devise.mappings[:user]
				get :edit

				expect(response).to have_http_status(200)
				expect(assigns(:user)).not_to eq @user1
			end
		end
		
	end
end