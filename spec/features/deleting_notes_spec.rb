require 'rails_helper'

RSpec.feature "Deleting Notes" do
	let!(:xfile) {FactoryGirl.create(:xfile)}
	let!(:user) {FactoryGirl.create(:user)}
	let!(:note) do 
		FactoryGirl.create(:note, xfile: xfile, author: user)
	end

	before do
		login_as(user)
		assign_role!(user, :viewer, xfile)
		visit xfile_note_path(xfile, note)
	end

	scenario "deleting successfull" do
		click_link "Delete Note"

		expect(page).to have_content("Note has been deleted")
		expect(page.current_url).to eq(xfile_url(xfile))
	end
end