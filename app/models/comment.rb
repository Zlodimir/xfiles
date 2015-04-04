class Comment < ActiveRecord::Base
  belongs_to :note
  belongs_to :author, class_name: "User"

  validates :text, presence: true

  delegate :xfile, to: :note
end
