require 'rails_helper'

RSpec.feature "Editing Users" do
	let!(:user) { FactoryGirl.create(:user)}
	let!(:admin) { FactoryGirl.create(:user, :admin) }

	before do
		login_as(admin)
		visit "/"
		click_link "Admin"
		click_link "Users"
		click_link user.email
		click_link "Edit User"
	end

	scenario "with valid credentials" do
		fill_in "Email", with: "newguy@xfile.com"
		click_button "Update User"

		expect(page).to have_content("User has been updated")
		expect(page).to have_content("newguy@xfile.com")
		expect(page).not_to have_content(user.email)
	end

	scenario "with toggling a user' admin ability" do
		check "Is an admin?"
		click_button "Update User"

		expect(page).to have_content("User has been updated")
		expect(page).to have_content("#{user.email} (Admin)")
	end
end