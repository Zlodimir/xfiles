require 'rails_helper'

RSpec.feature "Users can search for notes mathing specific criteria" do
	let!(:user) {FactoryGirl.create(:user)}
	let!(:xfile) {FactoryGirl.create(:xfile)}
	let(:open) {State.create(name: "Open", default: true)}
	let(:closed) {State.create(name: "Closed")}
	let!(:note1) do
		FactoryGirl.create(:note, title: "Create x-files", description: "fucking long note", author: user, tag_names: "iteration_1", xfile: xfile, state: open)
	end

	let!(:note2) do
		FactoryGirl.create(:note, title: "Create users", description: "fucking long note", author: user, tag_names: "iteration_2", xfile: xfile, state: closed)
	end

	before do
		assign_role!(user, :manager, xfile)
		login_as(user)
		visit "/"
		click_link xfile.name
	end

	scenario "searching by tag" do
		fill_in "Search", with: "tag:iteration_1"
		click_button "Search"

		within("#notes") do
			expect(page).to have_content("Create x-files")
			expect(page).not_to have_content("Create users")
		end
	end

	scenario "searching by state" do
		fill_in "Search", with: "state:Open"
		click_button "Search"

		within("#notes") do
			expect(page).to have_content("Create x-files")
			expect(page).not_to have_content("Create users")
		end
	end

	scenario "clicking on a tag" do
		click_link note1.title
		click_link "iteration_1"

		within("#notes") do
			expect(page).to have_content("Create x-files")
			expect(page).not_to have_content("Create users")
		end		
	end
end