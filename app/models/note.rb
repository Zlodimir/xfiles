class Note < ActiveRecord::Base
  belongs_to :xfile
  belongs_to :author, class_name: "User"
  has_many :assets, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true, length: {minimum: 10}

  accepts_nested_attributes_for :assets, reject_if: :all_blank
end
