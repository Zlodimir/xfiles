class Xfile < ActiveRecord::Base
	validates :name, presence: true
	has_many :notes, dependent: :delete_all
	has_many :roles, dependent: :delete_all
end
