require 'rails_helper'

RSpec.feature "Editing Notes" do
	let!(:xfile) {FactoryGirl.create(:xfile)}
	let!(:note) {FactoryGirl.create(:note, xfile: xfile)}

	before do
		visit xfile_note_path(xfile, note)
		click_link "Edit Note"
	end 

	scenario "with valid attributes" do
		fill_in "Title", with: "Edit note"
		fill_in "Description", with: "Some note changing"

		click_button "Update Note"

		expect(page).to have_content "Note has been updated"

		within("#note h2") do
			expect(page).to have_content "Edit note"
		end

		expect(page).to_not have_content(note.title)
	end

	scenario "with invalid attributes" do
		fill_in "Title", with: ""
		click_button "Update Note"

		expect(page).to have_content("Note has not been updated")
	end
end