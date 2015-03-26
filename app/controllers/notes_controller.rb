class NotesController < ApplicationController
	before_action :set_xfile
	before_action :set_note, only: [:show, :edit, :update, :destroy]
	def new
		@note = @xfile.notes.build
	end

	def create
		@note = @xfile.notes.build(note_params)

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
