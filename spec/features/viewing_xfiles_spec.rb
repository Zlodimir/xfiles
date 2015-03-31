require 'rails_helper'

RSpec.feature "Viewing X-Files" do

	let!(:user) { FactoryGirl.create(:user) }
	#xfile = FactoryGirl.create(:xfile, name: "A man has been seen a UFO!")
	let(:xfile) { FactoryGirl.create(:xfile) }

	before do
		login_as(user)
		assign_role!(user, :viewer, xfile)
	end
	
	scenario "Listening all X-Files" do
		FactoryGirl.create(:xfile, name: "Hidden")
		visit "/"
		expect(page).to_not have_content("Hidden")
		click_link xfile.name
		expect(page.current_url).to eql(xfile_url(xfile))
	end
end