module ApplicationHelper
	def admin_only(&block)
		block.call if current_user.try(:admin)
	end
end
