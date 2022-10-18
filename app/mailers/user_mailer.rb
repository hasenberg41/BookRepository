class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail(to: user.email, from: ENV['EMAIL_ADDRESS'].to_s, subject: 'Registration Confirmation')
  end
end
