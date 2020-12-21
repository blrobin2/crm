class TerritoryPolicy < ApplicationPolicy
  def update?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.sales?
        scope.where(sales_id: user.id)
      elsif user.advisor?
        scope.where(advisor_id: user.id)
      end
    end
  end
end
