class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.mailer_created.subject
  #
  def mailer_created
    # @user = params[:user]
    @greeting = "Hi"
    attachments['welcome image'] = File.read('app/assets/images/welcome.jpg')

    mail(
      from: "Hello <hello@email.com>",
      to: User.first.email,
      cc: Admin.all.pluck(:email),
      subject: "Welcome to Stock-Trading-App"
    )
  end
end