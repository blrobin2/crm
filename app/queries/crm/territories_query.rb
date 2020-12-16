module Crm
  class TerritoriesQuery < BaseQuery
    def scope
      Territory
    end

    def default_sort
      [name: :asc]
    end
  end
end
