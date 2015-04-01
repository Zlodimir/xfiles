require 'rails_helper'

RSpec.feature "Admin can manage user's roles" do
	let!(:admin) { FactoryGirl.create(:user, :admin) }
	let!(:user) { FactoryGirl.create(:user) }

	let!(:govno) { FactoryGirl.create(:xfile, name: "Govno detected") }
	let!(:shit) { FactoryGirl.create(:xfile, name: "Shit detected") }

	before do
		login_as(admin)
		visit "/"
		click_link "Admin"
		click_link "Users"
	end

	scenario "when assigning roles to an existing user" do
		click_link user.email
		click_link "Edit User"

		select "Viewer", from: "Govno detected"
		select "Manager", from: "Shit detected"

		click_button "Update User"
		expect(page).to have_content("User has been updated")

		click_link user.email
		expect(page).to have_content("Govno detected: Viewer")
		expect(page).to have_content("Shit detected: Manager")
	end
end