require 'rails_helper'

RSpec.feature "Admin can create new states for notes" do
	let(:user) { FactoryGirl.create :user, :admin }

	before do
		login_as(user)
	end

	scenario "with valid details" do
		visit "/"
		click_link "Admin"
		click_link "States"
		click_link "New State"
		fill_in "Name", with: "hz"
		fill_in "Color", with: "black"
		fill_in "Background", with: "Yellow"
		click_button "Create State"

		expect(page).to have_content("State has been created")
	end
end