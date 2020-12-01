module Api
  module V1
    class ApiController < ApplicationController
      include Authentication
      include CustomJsonApiResponders
      include ErrorHandling
      include JsonApiDeserialization
      include JsonApiResponders
      include Pundit

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      before_action :valid_jsonapi?

      private

      def user_not_authorized(exception)
        policy_name = exception.policy.class.to_s.underscore
        message = I18n.t("#{policy_name}.#{exception.query}", scope: 'pundit', default: :default)
        respond_with_error(403, message)
      end
    end
  end
end
