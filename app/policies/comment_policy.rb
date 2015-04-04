class CommentPolicy < NotePolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
end
