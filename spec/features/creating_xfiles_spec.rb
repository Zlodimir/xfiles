require 'rails_helper'

RSpec.feature "Creating X-Files" do
	before do 
		visit "/"
		click_link "New X-File"
	end

	scenario "A user can create new X-File" do

		fill_in "Name", with: "UFO"
		fill_in "Description", with: "A man has been seen UFO"
		click_button "Create Xfile"

		expect(page).to have_content("X-File has been created.")

		#xfile = Xfile.find_by(name: "UFO")

		#expect(page.current_url).to eql(xfile_url(xfile))
		#title = "UFO - X-Files"
		#expect(page).to have_title(title)
	end

	scenario "A user can not create new X-File without name" do
		click_button "Create Xfile"

		expect(page).to have_content("X-File has not been created")
		expect(page).to have_content("can't be blank")
	end
end