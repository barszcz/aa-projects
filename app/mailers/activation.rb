class Activation < ActionMailer::Base
  default from: "from@example.com"

  def activation_email(user)
    @user = user
    @activation_url = "http://localhost:3000/users/activate?token=#{user.activation_token}"
    mail(to: user.email, subject: "Music App Activation")
  end
end
