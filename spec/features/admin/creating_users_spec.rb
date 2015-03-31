require 'rails_helper'

RSpec.feature "Creating Notes" do
	let!(:admin) { FactoryGirl.create(:user, :admin) }

	before do
		login_as(admin)
		visit "/"
		click_link "Admin"
		click_link "Users"
		click_link "New User"
	end

	scenario "with valid credentials" do
		fill_in "Email", with: "newbie@xfile.com"
		fill_in "Password", with: "123456789"
		click_button "Create User"

		expect(page).to have_content("User has been created")
	end

	scenario "with the new admin user" do
		fill_in "Email", with: "admin.vasya@xfile.com"
		fill_in "Password", with: "123456789"
		check "Is an admin?"
		click_button "Create User"

		expect(page).to have_content("User has been created")
		expect(page).to have_content("admin.vasya@xfile.com (Admin)")
	end
end