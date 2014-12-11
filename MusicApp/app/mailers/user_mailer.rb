class UserMailer < ActionMailer::Base
  default from: "app@academy.io"
  
  def activation_email(user)
    @user = user
    mail(to: @user.email, subject: "Activation email")
  end
end
