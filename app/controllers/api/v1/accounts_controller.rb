module Api
  module V1
    class AccountsController < AuthenticatedController
      def index
        render_jsonapi(query_jsonapi.all)
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
