class UserPolicy < ApplicationPolicy
  def index?
    user.role.admin?
  end
end
