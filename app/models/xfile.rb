class Xfile < ActiveRecord::Base
	validates :name, presence: true
end
