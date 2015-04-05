require 'rails_helper'

RSpec.feature "Admin can manage states" do
	let(:user) { FactoryGirl.create :user, :admin }
	let!(:state) { FactoryGirl.create :state, name: "New"}

	before do
		login_as(user)
		visit "/"
	end

	scenario "mark state as default" do
		click_link "Admin"
		click_link "States"
		within list_item("New") do
			click_link "Make default"
		end

		expect(page).to have_content("'New' is now the default state")
	end
end