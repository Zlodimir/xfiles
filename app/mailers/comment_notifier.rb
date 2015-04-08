class CommentNotifier < ApplicationMailer
	def created(comment, user)
		@comment = comment
		@user = user
		@note = comment.note
		@xfile = @note.xfile
		subject = "[X-Files] #{@xfile.name} - #{@note.title}"
		mail(to: user.email, subject: subject)
	end
end
