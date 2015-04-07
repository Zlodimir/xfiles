require 'rails_helper'

RSpec.feature "Deleting tags" do
	let(:user) { FactoryGirl.create :user}
	let(:xfile) { FactoryGirl.create :xfile }
	let(:note) { FactoryGirl.create(:note, title: "EBAT BLEAD", description: "long long long long long", xfile: xfile, author: user, tag_names: "This tag must die") }

	before do
		login_as(user)
		assign_role!(user, :manager, xfile)

		visit xfile_note_path(xfile, note)
	end

	scenario "successfully", js: true do
		expect(page).to have_content("EBAT BLEAD")
		within tag("This tag must die") do
			click_link "remove"
		end
		expect(page).not_to have_content("This tag must die")
	end
end