module CapybaraFinders
	def list_item(content)
		find("div ul:not(.actions) li", text: content)
		#find("div ul li", text: content)
		#find("div [@id=states]", text: content)
	end

	def tag(name)
		find("div .tag", text: name)
	end
end

RSpec.configure do |c|
	c.include CapybaraFinders, type: :feature
end