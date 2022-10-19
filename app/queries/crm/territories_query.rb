module Crm
  class TerritoriesQuery < BaseQuery
    def scope
      super(Territory)
    end

    def filter_conditions
      {
        top_level: { parent_id: nil }
      }
    end

    def join_conditions
      [:advisor, :sales]
    end

    def default_sort
      [name: :asc]
    end
  end
end
