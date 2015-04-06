require 'rails_helper'

RSpec.feature "Creating Notes" do
	let(:user) {FactoryGirl.create(:user)}
	let!(:state) { FactoryGirl.create(:state, default: true, name: "New")}
	before do
		login_as(user)
		xfile = FactoryGirl.create(:xfile, name: "Some monster detected")
		assign_role!(user, :manager, xfile)
		visit "/"
		click_link "Some monster detected"
		click_link "New note"
	end

	scenario "with valid attributes" do
		fill_in "Title", with: "Some note"
		fill_in "Description", with: "Some big description long long long"
		click_button "Create Note"
		expect(page).to have_content("Note has been created")
		expect(page).to have_content("State: New")

		within("#note #author") do
			expect(page).to have_content("Created by #{user.email}")
		end
	end

	scenario "with missing attributes" do
		click_button "Create Note"
		expect(page).to have_content("Note has not been created")
		expect(page).to have_content("Title can't be blank")
		expect(page).to have_content("Description can't be blank")
	end	

	scenario "with an invalid description" do
		fill_in "Title", with: "Some note"
		fill_in "Description", with: "Som"
		click_button "Create Note"
		#expect(page).to have_content("Note has not been created")
		expect(page).to have_content("Description is too short")
	end	

	scenario "with an attachment" do
		fill_in "Title", with: "Some note"
		fill_in "Description", with: "Some long long note"
		attach_file "File #1", Rails.root.join("spec/fixtures/speed.txt")
		click_button "Create Note"
		expect(page).to have_content("Note has been created")
		expect(page).to have_link("speed.txt")
		#within("#note .assets") do
		#	expect(page).to have_content("speed.txt")
		#end
	end	

	scenario "persisting file uploads accross from displays" do
		attach_file "File #1", Rails.root.join("spec/fixtures/speed.txt")
		click_button "Create Note"
		fill_in "Title", with: "Some note"
		fill_in "Description", with: "Some long long note"
		click_button "Create Note"
		expect(page).to have_link("speed.txt")
	end

	scenario "with multiple attachments", js: true do
		fill_in "Title", with: "Some note"
		fill_in "Description", with: "Some lodng long note"
		
		attach_file "File #1", Rails.root.join("spec/fixtures/speed.txt")

		click_link "Add another file"

		attach_file "File #2", Rails.root.join("spec/fixtures/spin.txt")

		#attach_file "File #3", Rails.root.join("spec/fixtures/gradient.txt")

		click_button "Create Note"

		expect(page).to have_content("Note has been created")

		expect(page).to have_link("speed.txt")
		expect(page).to have_link("spin.txt")
		#expect(page).to have_link("gradient.txt")
	end

	scenario "with associated tags" do
		fill_in "Title", with: "Some note"
		fill_in "Description", with: "Some long long long long"
		fill_in "Tags", with: "browser,visual"
		click_button "Create Note"
		expect(page).to have_content("Note has been created")
		within("#note .page-header #tags") do
			expect(page).to have_content("browser")
			expect(page).to have_content("visual")
		end
	end
end