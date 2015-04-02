class Note < ActiveRecord::Base
  belongs_to :xfile
  belongs_to :author, class_name: "User"
  
  validates :title, presence: true
  validates :description, presence: true, length: {minimum: 10}

  mount_uploader :asset, AssetUploader
end
