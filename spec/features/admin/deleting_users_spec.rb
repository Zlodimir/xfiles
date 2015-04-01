require 'rails_helper'

RSpec.feature "An admin can delete users" do
	let!(:admin) { FactoryGirl.create(:user, :admin) }
	let!(:user) { FactoryGirl.create(:user) }

	before do
		login_as(admin)
		visit "/"
		click_link "Admin"
		click_link "Users"
		
	end

	scenario "delete successfully" do
		click_link user.email
		click_link "Delete User"

		expect(page).to have_content("User has been deleted")
		expect(page).to_not have_content user.to_s
	end

	scenario "but can not delete themselves" do
		click_link admin.email
		click_link "Delete User"

		expect(page).to have_content("You can not delete yourself")
	end
end