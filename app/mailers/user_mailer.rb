class UserMailer < ActionMailer::Base
  default from: "bike@anastasiiasbikes.com"

  def welcome(user)
	  @appname = "Bike Shop"
	  mail( :to => user.email,
      		:subject => "Welcome to #{@appname}!")
  end

  def contact_form(email,name, message)
  	@message = message

  	mail(:from => email, 
  		:to => 'anastasiia.pidvalna@gmail.com',
  		:subject => "A new contact form message from " + name)
  end
end
