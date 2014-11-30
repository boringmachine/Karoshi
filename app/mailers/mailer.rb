class Mailer < ActionMailer::Base
  default from: "info@karoshi.mybluemix.net"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sample.sample_mail.subject
  #
  def notification(from, to, body, post_id)
    mail to: to,
    subject: "Karoshi: #{from} comments on your post.",
    body: "#{body}\n https://karoshi.mybluemix.net/posts/#{post_id}"
  end
end