class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: "johan.grobler@gmail.com", from: "johan@ideapp.co.za", subject: 'Welcome to My Awesome Site')
  end

  def invoice_email(message)
    @message = message
    @invoice = message.invoice
    @user = message.user
    @url  = 'https://quoteme.co.za/invoice/' + @invoice.token  

    mail(to:  @message.email, from: "johan@ideapp.co.za", subject:  @message.subject)
  end
end
