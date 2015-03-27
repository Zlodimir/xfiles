class NotesController < ApplicationController
	before_action :set_xfile
	before_action :set_note, only: [:show, :edit, :update, :destroy]
	def new
		@note = @xfile.notes.build
	end

	def create
		@note = @xfile.notes.build(note_params)
		@note.author = current_user

		if @note.save
			flash[:notice] = "Note has been created"
			redirect_to [@xfile, @note]
		else
			flash.now[:alert] = "Note has not been created"
			render "new"
		end
	end

	def show

	end

	def edit

	end

	def update
		if @note.update(note_params)
			flash[:notice] = "Note has been updated"
			redirect_to [@xfile, @note]
		else
			flash.now[:alert] = "Note has not been updated"
			render "edit"
		end
	end

	def destroy
		@note.destroy

		flash[:notice] = "Note has been deleted"
		redirect_to @xfile
	end

	private 

	def set_xfile
		@xfile = Xfile.find(params[:xfile_id])
	end

	def set_note
		@note = Note.find(params[:id])
	end

	def note_params
		params.require(:note).permit(:title, :description)
	end
end
