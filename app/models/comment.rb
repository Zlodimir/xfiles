class Comment < ActiveRecord::Base
  belongs_to :state
  belongs_to :note
  belongs_to :author, class_name: "User"
  belongs_to :previous_state, class_name: "State"

  validates :text, presence: true

  delegate :xfile, to: :note

  after_create :set_note_state
  before_create :set_previous_state

private
  def set_note_state
  	note.state = state
  	note.save!
  end

  def set_previous_state
    self.previous_state = note.state
  end
end
