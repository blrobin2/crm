module Crm
  class UsersQuery < BaseQuery
    def scope
      User
    end

    def where_conditions
      {
        role: [:sales, :advisor]
      }
    end

    def default_sort
      [email: :asc]
    end
  end
end
