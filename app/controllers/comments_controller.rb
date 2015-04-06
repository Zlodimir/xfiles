class CommentsController < ApplicationController
	before_action :set_note
	def create
		whitelisted_params = comment_params
		unless policy(@note).change_state?
			whitelisted_params.delete(:state_id)
		end
		@comment = @note.comments.build(whitelisted_params)
		@comment.author = current_user
		authorize @comment, :create?

		if @comment.save
			flash[:notice] = "Comment has been created"
			redirect_to xfile_note_path(@note.xfile, @note)
		else
			flash.now[:alert] = "Comment has not been created"
			@xfile = @note.xfile
			render "notes/show"
		end
	end
private
	def set_note
		@note = Note.find(params[:note_id])
	end

	def comment_params
		params.require(:comment).permit(:text, :state_id)
	end
end
