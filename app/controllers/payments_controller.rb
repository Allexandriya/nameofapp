class PaymentsController < ApplicationController
	
	# POST /payments
  	# POST /payments.json
	def create
		@product = Product.find(params[:product_id])
		@user = current_user
		token = params[:stripeToken]
		# Create the charge on Stripe's servers - this will charge the user's card
		begin
			charge = Stripe::Charge.create(
				:amount => @product.price * 100, #in cents
				:currency => 'usd'
				:source => token,
				:description => params[:stripeEmail]
			)

			if charge.paid
				Order.create(
					:product_id => @product.id
					:user_id => @user.id
					:total => @product.price
				)
			end

			rescue Stripe::CardError => e
		      	#card has been declined
		      	body = e.json_body
		      	err = body[:error]
		      	flash[:error] = "Sorry, your card was declined with the error: #{err[:message]}"
	    	end

    	end

		respond_to do |format|
      	    format.html { redirect_to @product, notice: '' }
        	format.json { render :show, status: :created, location: @product }
        end

	end
end
