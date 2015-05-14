class Contact < ActionMailer::Base
  default from: "contact@blogapp.com"
  def send_mail(user)
    @user = user
    mail(to: "prashantvithani@gmail.com", subject: "Complaints")
  end
end
