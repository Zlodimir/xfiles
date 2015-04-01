class NotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
  	user.try(:admin?) || record.xfile.roles.exists?(user_id: user)
  end
end
