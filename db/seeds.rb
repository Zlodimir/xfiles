# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless User.exists?(email: "admin@xfile.com") 
	User.create(email: "admin@xfile.com", password: "123456789", admin: true)
end

unless User.exists?(email: "user@xfile.com") 
	User.create(email: "user@xfile.com", password: "123456789")
end

["Ebala detected", "Chupacabra detected"].each do | name |
	if not Xfile.exists?(name: name)
		x = Xfile.create(name: name, description: "A sample xfile about #{name}")
	else
		x = Xfile.where(name: name).first
	end

	unless Note.exists?(title: "#{name} note")
		u = User.where(email: "admin@xfile.com").first
		Note.create(title: "#{name} note", description: "A long note description about #{name}", xfile: x, author: u)
	end
end

unless State.exists?
	State.create(name: "New", background: "#0066CC", color: "white", default: true)
	State.create(name: "Open", background: "#008000", color: "white")
	State.create(name: "Closed", background: "#990000", color: "white")
	State.create(name: "Avesome", background: "#663399", color: "white")
end