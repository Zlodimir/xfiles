class Comment < ActiveRecord::Base
  after_create :associate_tags_with_note
  belongs_to :state
  belongs_to :note
  belongs_to :author, class_name: "User"
  belongs_to :previous_state, class_name: "State"

  validates :text, presence: true

  delegate :xfile, to: :note

  after_create :set_note_state
  before_create :set_previous_state

  attr_accessor :tag_names

private
  def set_note_state
  	note.state = state
  	note.save!
  end

  def set_previous_state
    self.previous_state = note.state
  end

  def associate_tags_with_note
    if tag_names
      tag_names.split(",").each do | name |
        note.tags << Tag.find_or_create_by(name: name)
      end
    end
  end
end
