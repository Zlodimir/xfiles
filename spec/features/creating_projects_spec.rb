require 'rails_helper'

RSpec.feature "Creating X-Files" do
	scenario "A user can create new X-File" do
		visit "/"

		click_link "New X-File"

		fill_in "Название", with: "UFO"
		fill_in "Дэскрипшн", with: "A man has been seen UFO"
		click_button "Create X-File"

		expect(page).to have_content("X-File has been created.")
	end
end