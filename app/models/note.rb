class Note < ActiveRecord::Base
  belongs_to :xfile
  validates :title, presence: true
  validates :description, presence: true, length: {minimum: 10}
end
