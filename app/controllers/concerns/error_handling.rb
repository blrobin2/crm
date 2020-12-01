module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from Crm::UnauthorizedError do
      respond_with_error(401, 'Not authorized')
    end
  end
end
