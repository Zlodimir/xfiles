require 'rails_helper'

RSpec.feature "User can comment on ticket" do
	let(:user) { FactoryGirl.create :user }
	let(:xfile) { FactoryGirl.create :xfile }
	let(:note) { FactoryGirl.create(:note, title: "EBAT BLEAD", xfile: xfile, author: user) }

	before do
		login_as(user)
		assign_role!(user, :manager, xfile)

		visit xfile_note_path(xfile, note)
		#click_link xfile.name
	end

	scenario "with valid attributes" do
		#click_link "EBAT BLEAD"
		fill_in "Text", with: "Added a comment!"
		click_button "Create Comment"

		expect(page).to have_content("Comment has been created")
		within("#comments") do
			expect(page).to have_content("Added a comment!")
		end
	end

	scenario "with invalid attributes" do
		#click_link note.title
		click_button "Create Comment"

		expect(page).to have_content("Comment has not been created")
	end
end