class NotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
  	user.try(:admin?) || record.xfile.has_member?(user)
  end

  def create?
  	user.try(:admin?) ||
  	record.xfile.has_manager?(user) ||
  	record.xfile.has_editor?(user)
  end

  def update?
    user.try(:admin?) ||
    record.xfile.has_manager?(user) ||
    (record.xfile.has_editor?(user) && record.author == user)
  end

  def destroy?
    user.try(:admin?) || record.xfile.has_manager?(user)
  end

  def change_state?
    destroy?
  end

  def tag?
    destroy?
  end
end
