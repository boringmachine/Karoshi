class AddAttachmentPhotoToCommunities < ActiveRecord::Migration
  def self.up
    change_table :communities do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :communities, :photo
  end
end
