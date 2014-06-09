class Mailer < ActionMailer::Base
  default from: "info@karoshi.heroku.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sample.sample_mail.subject
  #
  def notification(from, to, body, post_id)
    mail to: to.email,
    subject: "Karoshi:#{from.username} comments on your post.",
    body: "#{body}\n https://ancient-falls-3709.herokuapp.com/posts/#{post_id}"
  end
end