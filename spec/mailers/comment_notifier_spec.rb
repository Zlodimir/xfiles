require "rails_helper"

RSpec.describe CommentNotifier, :type => :mailer do
  describe "created" do
  	let!(:xfile) { FactoryGirl.create(:xfile) }
  	let!(:note_owner) { FactoryGirl.create(:user) }
  	let!(:note) do
  		FactoryGirl.create(:note, xfile: xfile, author: note_owner)
  	end

  	let!(:commenter) { FactoryGirl.create(:user) }
  	let!(:comment) { FactoryGirl.create(:comment, note: note, author: commenter, text: "Test comment") }

  	let!(:email) do
  		CommentNotifier.created(comment, note_owner)
  	end

  	it "sends out an email to owner about new comment" do
  		expect(email.to).to include(note_owner.email)
  		title = "#{note.title} for #{xfile.name} has been updated"
  		expect(email.body.to_s).to include(title)
  		expect(email.body.to_s).to include("#{comment.author.email} wrote:")
  		expect(email.body.to_s).to include(comment.text)
  	end
  end
end
