class XfilesController < ApplicationController
	before_action :set_project, only: [:show, :edit, :update, :destroy]

	def index
		@xfiles = Xfile.all
	end

	def show
		@xfile = Xfile.find(params[:id])
	end

	def edit
		@xfile = Xfile.find(params[:id])
	end

	def update
		@xfile = Xfile.find(params[:id])
		if @xfile.update(project_params)
			flash[":notice"] = "X-File has been updated"
			redirect_to @xfile
		else
			flash.now[:alert] = "X-File has not been updated"
			render "edit"
		end
	end

	private

	def project_params
		params.require(:xfile).permit(:name, :description)
	end

	def set_project
		@xfile = Xfile.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:alert] = "The X-File you are looking for could not be found"
		redirect_to xfiles_path
	end
end
