# Preview all emails at http://localhost:3000/rails/mailers/sharing
class SharingPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/sharing/share_blog
  def share_blog
    Sharing.share_blog
  end

end
