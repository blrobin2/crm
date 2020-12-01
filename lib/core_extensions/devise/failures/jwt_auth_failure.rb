module Devise
  module Failures
    class JwtAuthFailure < Devise::FailureApp
      def respond
        request.format == :jsonapi ? json_failure : super
      end

      def json_failure
        Honeybadger.notify(info: 'JWT Auth failure')
        self.status = 401
        self.content_type = 'application/json'
        self.response_body = { errors: [{ detail: 'Not Authorized' }] }.to_json
      end
    end
  end
end
