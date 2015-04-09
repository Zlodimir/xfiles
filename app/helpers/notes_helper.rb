module NotesHelper
	def state_transition_for(comment)
		if comment.previous_state != comment.state
			content_tag(:p) do
				value = "<strong><i = class='fa fa-gear'></i> state changed</strong>"
				if comment.previous_state.present?
					value += " from #{ render comment.previous_state}"
				end
				value += " to #{ render comment.state }"
				value.html_safe
			end
		end
	end

	def toggle_watching_button(note)
		text = if note.watchers.include?(current_user)
			"Unwatch"
		else
			"Watch"
		end
		link_to text, watch_xfile_note_path(note.xfile, note), class: text.parameterize, method: :post
	end
end
