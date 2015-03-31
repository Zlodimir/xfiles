class Admin::XfilesController < Admin::BaseController
	before_action :set_xfile, only: [:show, :edit, :update, :destroy]

	def new
		@xfile = Xfile.new
	end

	def create 
		@xfile = Xfile.new(xfile_params)

		if @xfile.save
			flash[:notice] = "X-File has been created."
			redirect_to @xfile
		else
			flash.now[:alert] = "X-File has not been created"
			render "new"
		end
	end

	def destroy 
		#@xfile = Xfile.find(params[:id])
		@xfile.destroy

		flash[":notice"] = "X-File has been deleted."

		redirect_to xfiles_path
	end

	private

	def xfile_params
		params.require(:xfile).permit(:name, :description)
	end

	def set_xfile
		@xfile = Xfile.find(params[:id])
	end
end
