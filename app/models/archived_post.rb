class ArchivedPost
  include Mongoid::Document
  include Mongoid::Timestamps
	include Mongoid::Paperclip
	include Tenacity

  field :title, type: String
  field :body, type: String
  t_belongs_to :user
  has_many :archived_comments, dependent: :destroy
  
  has_mongoid_attached_file :header_image, :styles => { :header => "1200x1200>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :header_image, :content_type => /\Aimage\/.*\Z/
end
