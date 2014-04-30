class Mailer < ActionMailer::Base
  default from: "info@heroku-karoshi.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sample.sample_mail.subject
  #
  def sample_mail
    @greeting = "Hi"

    mail to: "flank1990@mail.ru", subject: "test mail"
  end
end