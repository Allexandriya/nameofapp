class StaticPagesController < ApplicationController
  def index
  	@products = Product.all
  end

  def thank_you
  	@name = params[:name]
  	@email = params[:email]
  	@message = params[:message]
    UserMailer.contact_form(@email, @name, @message).deliver

  	ActionMailer::Base.mail(:from => @email, 
  		:to => 'anastasiia.pidvalna@gmail.com',
  		:subject => "A new contact form message from " + @name,
  		:body => @message).deliver
  end
end