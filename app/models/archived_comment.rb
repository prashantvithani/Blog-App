class ArchivedComment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Tenacity
  field :content, type: String
  t_belongs_to :user
  belongs_to :archived_post
end
