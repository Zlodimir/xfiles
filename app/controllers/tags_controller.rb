class TagsController < ApplicationController
	def remove
		@note = Note.find(params[:note_id])
		@tag = Tag.find(params[:id])

		authorize @note, :tag?

		@note.tags.destroy(@tag)
		head :ok
	end
end
