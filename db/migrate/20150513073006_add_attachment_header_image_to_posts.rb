class AddAttachmentHeaderImageToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :header_image
    end
  end

  def self.down
    remove_attachment :posts, :header_image
  end
end
