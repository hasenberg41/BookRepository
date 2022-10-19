class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail(to: user.email, from: 'BookRepository', subject: 'Registration Confirmation')
  end
end
