class XfilesController < ApplicationController
	def index

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
			#nothing
		end
	end

	def show
		@xfile = Xfile.find(params[:id])
	end

	def project_params
		params.require(:xfile).permit(:name, :description)
	end
end
