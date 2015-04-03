class AssetsController < ApplicationController
	skip_after_action :verify_authorized, only: [:new]
	def show
		asset = Asset.find(params[:id])
		authorize asset, :show?
		send_file asset.asset.path, disposition: :inline
	end

	def new
		@index = params[:index].to_i
		@note = Note.new
		@note.assets.build
		render layout: false
	end
end
