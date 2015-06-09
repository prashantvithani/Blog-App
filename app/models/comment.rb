class Comment < ActiveRecord::Base
	include Tenacity
  belongs_to :post
  belongs_to :user
end
