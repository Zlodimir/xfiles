require 'rails_helper'

RSpec.feature "Authorization errors" do
	let(:xfile) { FactoryGirl.create :xfile }

	scenario "are handled gracefully" do
		visit xfile_path(xfile)

		expect(page.current_path).to eq(root_path)
		expect(page).to have_content("You aren't allowed to do that")
	end
end