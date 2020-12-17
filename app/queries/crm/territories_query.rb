module Crm
  class TerritoriesQuery < BaseQuery
    def scope
      Territory
    end

    def filter_conditions
      {
        top_level: { parent_id: nil }
      }
    end

    def default_sort
      [name: :asc]
    end
  end
end
