require 'rails_helper'

RSpec.feature "Viewing Notes" do
	before do 
		govno = FactoryGirl.create(:xfile, name: "To eshe govno")

		FactoryGirl.create(:note, xfile: govno, title: "Make govno free!", description: "And you feel you like govno!")

		shit = FactoryGirl.create(:xfile, name: "Another sort of shit")

		FactoryGirl.create(:note, xfile: shit, title: "Standart shit", description: "Another shit of type")

		visit "/"
	end

	scenario "for a given xfile" do
		click_link "To eshe govno"

		expect(page).to have_content("Make govno free!")
		expect(page).to_not have_content("Standart shit")

		click_link "Make govno free!"
		within('#note h2') do
			expect(page).to have_content("Make govno free!")	
		end
		expect(page).to have_content("And you feel you like govno!")	
	end
end