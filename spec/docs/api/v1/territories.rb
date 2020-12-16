module Docs
  module Api
    module V1
      module Territories
        extend Dox::DSL::Syntax

        document :api do
          resource 'Territories' do
            endpoint '/territories'
            group 'Territories'
          end
        end

        document :index do
          action 'List territories'
        end
      end
    end
  end
end
