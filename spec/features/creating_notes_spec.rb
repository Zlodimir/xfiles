require 'rails_helper'

RSpec.feature "Creating Notes" do
	before do
		FactoryGirl.create(:xfile, name: "Some monster detected")
		visit "/"
		click_link "Some monster detected"
		click_link "New note"
	end

	scenario "with valid attributes" do
		fill_in "Title", with: "Some note"
		fill_in "Description", with: "Some big description long long long"
		click_button "Create Note"
		expect(page).to have_content("Note has been created")
	end

	scenario "with missing attributes" do
		click_button "Create Note"
		expect(page).to have_content("Note has not been created")
		expect(page).to have_content("Title can't be blank")
		expect(page).to have_content("Description can't be blank")
	end	

	scenario "with an invalid description" do
		fill_in "Title", with: "Some note"
		fill_in "Description", with: "Som"
		click_button "Create Note"
		#expect(page).to have_content("Note has not been created")
		expect(page).to have_content("Description is too short")
	end	
end