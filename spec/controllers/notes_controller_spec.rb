require 'rails_helper'

RSpec.describe NotesController, :type => :controller do
	let!(:xfile) { FactoryGirl.create(:xfile) }
	let!(:user) { FactoryGirl.create(:user) }

	before :each do
		assign_role!(user, :editor, xfile)
		sign_in user
	end

	it "can create notes, but not tag them" do
		post :create, note: { title: "New note", description: "long long long long", tag_names: "one,two"}, xfile_id: xfile.id
		expect(Note.last.tags).to be_empty
	end
end 
