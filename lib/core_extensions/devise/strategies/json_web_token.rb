module Devise
  module Strategies
    class JsonWebToken < Devise::Strategies::Authenticatable
      def valid?
        request.headers['authorization'].present?
      end

      def authenticate!
        return fail! unless claims
        return fail! unless required_claims_present?

        success! user
      end

      def user
        @user ||= JtiClaim.find_by!(value: claims['jti']).user
      rescue ActiveRecord::RecordNotFound
        Honeybadger.notify(info: 'Failed to find user with JWT Token')
        raise Crm::RecordNotFound
      end

      protected

      def claims
        @claims ||= begin
          stragegy, token = request.headers['authorization'].split
          JWTSerializer.decode(token) if stragegy == 'Bearer'
        end
      end

      def required_claims_present?
        claims.key?('jti')
      end
    end
  end
end
