require 'rails_helper'

RSpec.describe XfilesController, :type => :controller do
	it "displays an error for a missing xfile" do
		get :show, id:"not_id"
		expect(response).to redirect_to(xfiles_path)
		message = "The X-File you are looking for could not be found"
		expect(flash[:alert]).to eql(message)
	end
end
