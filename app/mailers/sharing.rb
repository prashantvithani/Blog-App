class Sharing < ActionMailer::Base
  helper :application
  default from: "no-reply@blogapp.com"
  def share_blog(sender, email, author, post)
    @author = author
    @post = post
    @sender = sender
    mail(to: email, subject: "Checkout this blog.")
  end
end
