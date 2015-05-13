class Post < ActiveRecord::Base
	belongs_to :user

	validates :title, :body, presence: true

	has_attached_file :header_image, :styles => { :header => "1200x1200>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :header_image, :content_type => /\Aimage\/.*\Z/


	has_many :comments, dependent: :destroy
end
