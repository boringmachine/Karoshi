class Mailer < ActionMailer::Base
  default from: "info@heroku-karoshi.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sample.sample_mail.subject
  #
  def notification(user, body)
    mail to: user.email,
    subject: "Someone comments to your post.",
    body: body + request.url
  end
end