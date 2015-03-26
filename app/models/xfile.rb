class Xfile < ActiveRecord::Base
	validates :name, presence: true
	has_many :notes
end
