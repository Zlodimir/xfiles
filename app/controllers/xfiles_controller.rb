class XfilesController < ApplicationController
	def index
		@xfiles = Xfile.all
	end

	def new
		@xfile = Xfile.new
	end

	def create 
		@xfile = Xfile.new(project_params)

		if @xfile.save
			flash[:notice] = "X-File has been created."
			redirect_to @xfile
		else
			flash.now[:alert] = "X-File has not been created"
			render "new"
		end
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

	def project_params
		params.require(:xfile).permit(:name, :description)
	end
end
