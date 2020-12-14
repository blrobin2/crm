module Api
  module V1
    class UsersController < AuthenticatedController
      def index
        authorize User
        render_jsonapi(query_jsonapi.all)
      end

      private

      def query_class
        Crm::UsersQuery
      end
    end
  end
end
