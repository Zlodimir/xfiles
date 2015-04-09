require 'rails_helper'

RSpec.feature "Users can watch and unwatch notes" do
	let!(:user) {FactoryGirl.create(:user) }
	let!(:xfile) {FactoryGirl.create(:xfile)}
	let!(:note) do
		FactoryGirl.create(:note, title: "Create x-files", description: "fucking long note", author: user, xfile: xfile)
	end

	before do
		assign_role!(user, :manager, xfile)
		login_as(user)
		visit xfile_note_path(xfile, note)
	end

	scenario "unwatching notes and rewatching notes" do
		within("#watchers") do
			expect(page).to have_content(user.email)
		end

		click_link "Unwatch"
		expect(page).to have_content("You are no longer watching this note")
		
		within("#watchers") do
			expect(page).not_to have_content(user.email)
		end

		click_link "Watch"
		expect(page).to have_content("You are now watching this note")

		within("#watchers") do
			expect(page).to have_content(user.email)
		end
	end
end