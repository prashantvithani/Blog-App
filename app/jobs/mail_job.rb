class MailJob < Struct.new(:sender, :emails, :author, :post)
	def perform
		emails.each { |e| Sharing.share_blog(sender, e, author, post).deliver }	
	end
end