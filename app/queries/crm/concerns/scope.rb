module Crm
  module Concerns
    module Scope
      def scopes
        return {} unless filter_scope

        scope_conditions[filter_scope]
      end

      def filter_scope
        params.dig(:filter, :scope)&.to_sym
      end

      def filter_scope!
        filter_scope || raise(ActionController::BadRequest.new, 'Missing filter(s)')
      end

      def scope_conditions
        {}
      end
    end
  end
end
