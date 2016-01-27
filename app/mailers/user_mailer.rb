class UserMailer < ActionMailer::Base
  default from: "contacts@anastasiiasbikes.com"

  def contact_form(email,name, message)
  	@message = message

  	mail(:from => email, 
  		:to => 'anastasiia.pidvalna@gmail.com',
  		:subject => "A new contact form message from " + name)
  end
end
