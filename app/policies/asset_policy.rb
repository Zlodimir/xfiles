class AssetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
  	user.try(:admin?) || record.note.xfile.has_member?(user)
  end
end
