require 'rails_helper'

RSpec.feature "Creating Notes" do
	let(:xfile) { FactoryGirl.create(:xfile) }
	let(:user) { FactoryGirl.create(:user)}
	let(:note) { FactoryGirl.create(:note, xfile: xfile, author: user) }
	let(:asset) { FactoryGirl.create :asset, note: note, file: "spec/fixtures/speed.txt" }

	before do
		assign_role!(user, :viewer, xfile)
		login_as(user)
	end

	scenario "successfully" do
		visit xfile_note_path(xfile, note)
		#click_link "speed.txt"
		#expect(page).to have_link "speed.txt"
		#expect(current_path).to eq asset_path(asset)
		#expect(page).to have_content("maza faka long long speed text EBAT!")
	end
end