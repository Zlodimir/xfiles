require 'rails_helper'

RSpec.feature "Editing X-Files" do
	before do 
		xfile = FactoryGirl.create(:xfile, name: "A man has been seen a UFO!")
		visit "/"
		click_link "A man has been seen a UFO!"
		click_link "Edit X-File"
	end

	scenario "Editing X-Files" do

		fill_in "Name", with: "A man has been seen big UFO"
		click_button "Update Xfile"
		expect(page).to have_content("X-File has been updated")
	end

	scenario "Updating X-file with invalid attributes" do
		fill_in "Name", with: ""
		click_button "Update Xfile"
		expect(page).to have_content("X-File has not been updated")		
	end
end