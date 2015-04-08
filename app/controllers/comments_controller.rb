class CommentsController < ApplicationController
	before_action :set_note
	def create
		whitelisted_params = sanitize_parameters!
		@creator = CommentCreator.build(@note.comments, current_user, whitelisted_params)
		authorize @note, :create?

		if @creator.save
			flash[:notice] = "Comment has been created"
			redirect_to xfile_note_path(@note.xfile, @note)
		else
			flash.now[:alert] = "Comment has not been created"
			@xfile = @note.xfile
			@comment = @creator.comment
			render "notes/show"
		end
	end
private
	def set_note
		@note = Note.find(params[:note_id])
	end

	def comment_params
		params.require(:comment).permit(:text, :state_id, :tag_names)
	end

	def sanitize_parameters!
		whitelisted_params = comment_params
		unless policy(@note).change_state?
			whitelisted_params.delete(:state_id)
		end
		unless policy(@note).tag?
			whitelisted_params.delete(:tag_names)
		end

		whitelisted_params
	end
end
