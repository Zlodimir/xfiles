require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
	let(:user) { FactoryGirl.create(:user) }
	let(:xfile) { Xfile.create(name: "Xfile") }
	let(:state) { State.create(name: "Hacked") }

	let(:note) do
		xfile.notes.create(title: "Fucking title", description: "Fucking description", author: user)
	end

	context "a user without permission to set state" do
		before :each do
			assign_role!(user, :editor, xfile)
			sign_in user
		end

		it "cannot transition a state by passing through state_id" do
			post :create, {comment: {text: "Did i hack it?", state_id: state.id}, note_id: note.id }
			note.reload
			expect(note.state).to be_nil
		end
	end

	context "a user without permission to tag a ticket" do
		before do
			assign_role!(user, :editor, xfile)
			sign_in user
		end

		it "cannot tag a ticket when creating a comment" do
			post :create, { comment: { text: "Tag!", tag_names: "one,two"}, note_id: note.id}
			note.reload
			expect(note.tags).to be_empty
		end
	end
end
