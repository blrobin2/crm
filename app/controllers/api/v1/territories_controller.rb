module Api
  module V1
    class TerritoriesController < AuthenticatedController
      def index
        render_jsonapi(query_jsonapi.all)
      end

      def update
        territory = query_jsonapi.find(params[:id])
        authorize territory
        territory.update(territory_params)

        render_jsonapi(territory)
      end

      private

      def query_class
        Crm::TerritoriesQuery
      end

      def territory_params
        params.from_jsonapi.require(:territory).permit(
          :sales_id,
          :advisor_id
        )
      end
    end
  end
end
