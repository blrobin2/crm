module Api
  module V1
    class AuthenticatedController < ApiController
      before_action :authenticate_api_user!, :set_paper_trail_whodunnit
    end
  end
end
