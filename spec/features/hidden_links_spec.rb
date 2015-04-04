require 'rails_helper'

RSpec.feature "Hidden links" do
	let(:user) {FactoryGirl.create(:user)}
	let(:admin) {FactoryGirl.create(:user, :admin)}
	let(:xfile) {FactoryGirl.create(:xfile)}
	let(:note) do
		FactoryGirl.create(:note, xfile: xfile, author: user)
	end

	#context "anonymous user" do
	#	scenario "can not see the New X file link" do
	#		visit "/"
	#		expect(page).not_to have_link "New X-File"
	#	end
	#end

	context "regular user" do
		before do
			login_as(user)
			assign_role!(user, :viewer, xfile)
		end

		scenario "can not see the New X-file link" do
			visit "/"
			expect(page).not_to have_link "New X-File"
		end

		scenario "can not see Edit Xfile link" do
			visit xfile_path(xfile)
			expect(page).not_to have_link "Edit X-File"
		end

		scenario "can not see the New Note link" do
			visit xfile_path(xfile)
			expect(page).not_to have_link "New note"
		end

		scenario "can not see the Edit note link" do
			visit xfile_note_path(xfile, note)
			expect(page).not_to have_link "Edit Note"
		end

		scenario "can not see Delete Note link" do
			visit xfile_note_path(xfile, note)
			expect(page).not_to have_link "Delete Note"
		end

		scenario "can not see New Comment form" do
			visit xfile_note_path(xfile, note)
			expect(page).not_to have_heading "New comment"
		end
	end	

	context "admin user" do
		before do
			login_as(admin)
		end
		scenario "can see the New X-file link" do
			visit "/"
			expect(page).to have_link "New X-File"
		end

		scenario "can see Edit Xfile link" do
			visit xfile_path(xfile)
			expect(page).to have_link "Edit X-File"
		end

		scenario "can see the New Note link" do
			visit xfile_path(xfile)
			expect(page).to have_link "New note"
		end

		scenario "can see the Edit note link" do
			visit xfile_note_path(xfile, note)
			expect(page).to have_link "Edit Note"
		end

		scenario "can see Delete Note link" do
			visit xfile_note_path(xfile, note)
			expect(page).to have_link "Delete Note"
		end

		scenario "can see New Comment form" do
			visit xfile_note_path(xfile, note)
			expect(page).to have_heading "New comment"
		end
	end	

	#context "anonymous user" do
	#	scenario "can not see the Delete X-file link" do
	#		visit xfile_path(xfile)
	#		expect(page).not_to have_link "Delete X-File"
	#	end
	#end

	context "regular user" do
		before do
			login_as(user)
			assign_role!(user, :viewer, xfile)
		end
		scenario "can not see the Delete X-file link" do
			visit xfile_path(xfile)
			expect(page).not_to have_link "Delete X-File"
		end
	end

	context "admin user" do
		before do
			login_as(admin)
			assign_role!(admin, :viewer, xfile)
		end
		scenario "can see the Delete X-file link" do
			visit xfile_path(xfile)
			expect(page).to have_link "Delete X-File"
		end
	end
end