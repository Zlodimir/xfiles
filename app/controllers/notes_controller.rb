class NotesController < ApplicationController
	before_action :set_xfile
	before_action :set_note, only: [:show, :edit, :update, :destroy]
	def new
		@note = @xfile.notes.build

		authorize @note, :create?

		#3.times { @note.assets.build }
		@note.assets.build
	end

	def create
		whitelisted_params = note_params
		@note = @xfile.notes.new
		#@note = @xfile.notes.build(note_params)
		unless policy(@note).tag?
			whitelisted_params.delete(:tag_names)
		end
		@note.attributes = whitelisted_params
		@note.author = current_user
		authorize @note, :create?
		
		if @note.save
			flash[:notice] = "Note has been created"
			redirect_to [@xfile, @note]
		else
			flash.now[:alert] = "Note has not been created"
			render "new"
		end
	end

	def show
		authorize @xfile, :show?
		@comment = @note.comments.build(state_id: @note.state_id)
	end

	def edit
		authorize @note, :update?
	end

	def update
		authorize @note, :update?

		if @note.update(note_params)
			flash[:notice] = "Note has been updated"
			redirect_to [@xfile, @note]
		else
			flash.now[:alert] = "Note has not been updated"
			render "edit"
		end
	end

	def destroy
		authorize @note, :destroy?
		@note.destroy

		flash[:notice] = "Note has been deleted"
		redirect_to @xfile
	end

	def search
		authorize @xfile, :show?
		@notes = @xfile.notes.search(params[:search] || "")
		render "xfiles/show"
	end

	private

	def set_xfile
		@xfile = Xfile.find(params[:xfile_id])
	end

	def set_note
		@note = Note.find(params[:id])
	end

	def note_params
		params.require(:note).permit(:title, :description, :tag_names, assets_attributes: [:asset, :asset_cache])
	end
end
