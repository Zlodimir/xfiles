require 'rails_helper'

RSpec.feature "Users can receive notifications about note updates" do
	let!(:alice) {FactoryGirl.create(:user, email: "alice@xfile.com")}
	let!(:bob) {FactoryGirl.create(:user, email: "bob@xfile.com")}
	let!(:xfile) {FactoryGirl.create(:xfile)}
	let!(:note) do
		FactoryGirl.create(:note, title: "Create x-files", description: "fucking long note", author: alice, xfile: xfile)
	end

	before do
		assign_role!(alice, :manager, xfile)
		assign_role!(bob, :manager, xfile)
		login_as(bob)
		visit xfile_note_path(xfile, note)
	end

	scenario "note authors automatically receive notifications" do
		fill_in "Text", with: "is it out yet?"
		click_button "Create Comment"

		email = find_email!(alice.email)
		expect_subject = "[X-Files] #{xfile.name} - #{note.title}"
		expect(email.subject).to eq(expect_subject)

		click_first_link_in_email(email)
		expect(page).to have_heading(note.title)
	end

	scenario "comment authors are automatically subscribed to a note" do
		fill_in "Text", with: "is it not yet?"
		click_button "Create Comment"
		expect(page).to have_content("Comment has been created")
		click_link "Sign Out"
		reset_mailer
		login_as(alice)
		visit xfile_note_path(xfile, note)
		fill_in "Text", with: "Noy yet - Sorry!"
		click_button "Create Comment"

		expect(page).to have_content("Comment has been created")
		expect(unread_emails_for(bob.email).count).to eq 1
		expect(unread_emails_for(alice.email).count).to eq 0
	end
end