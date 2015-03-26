require 'rails_helper'

RSpec.feature "Deleting Notes" do
	let!(:xfile) {FactoryGirl.create(:xfile)}
	let!(:note) {FactoryGirl.create(:note, xfile: xfile)}

	before do
		visit xfile_note_path(xfile, note)
	end

	scenario "deleting successfull" do
		click_link "Delete Note"

		expect(page).to have_content("Note has been deleted")
		expect(page.current_url).to eq(xfile_url(xfile))
	end
end