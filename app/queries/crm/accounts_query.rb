module Crm
  class AccountsQuery < BaseQuery
    def scope
      super(Account)
    end

    def default_sort
      [name: :asc]
    end
  end
end
