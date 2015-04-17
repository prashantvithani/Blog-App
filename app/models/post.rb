class Post < ActiveRecord::Base
	belongs_to :user

	validates :title, :body, presence: true

	has_many :comments, dependent: :destroy
end
