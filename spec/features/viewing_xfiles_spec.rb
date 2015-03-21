require 'rails_helper'

RSpec.feature "Viewing X-Files" do

	scenario "Listening all X-Files" do
		xfile = FactoryGirl.create(:xfile, name: "A man has been seen a UFO!")
		visit "/"
		click_link "A man has been seen a UFO!"
		expect(page.current_url).to eql(xfile_url(xfile))
	end
end