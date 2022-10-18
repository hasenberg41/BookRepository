class ApplicationMailer < ActionMailer::Base
  default from: ENV['EMAIL_ADDRESS']
  layout "mailer"
end
