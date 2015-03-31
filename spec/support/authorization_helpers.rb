module AuthorizationHelpers
	def assign_role!(user, role, xfile)
		Role.where(user: user, xfile: xfile).delete_all
		Role.create(user: user, role: role, xfile: xfile)
	end
end

RSpec.configure do | c |
	c.include AuthorizationHelpers
end