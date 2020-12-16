module Api
  module V1
    class TerritoriesController < AuthenticatedController
      def index
        render_jsonapi(query_jsonapi.all)
      end

      private

      def query_class
        Crm::TerritoriesQuery
      end
    end
  end
end
