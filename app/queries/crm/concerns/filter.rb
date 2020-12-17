module Crm
  module Concerns
    module Filter
      def filters
        filter_keys.map do |filter|
          filter_conditions[filter.to_sym]
        end.compact
      end

      def wheres
        where_conditions.merge(where_params)
      end

      def filter_conditions
        {}
      end

      def where_conditions
        {}
      end

      def filter_keys
        return [] unless params[:filter]

        params[:filter].keys
      end

      def where_params
        params[:where].to_h.transform_keys(&:to_sym)
      end
    end
  end
end
