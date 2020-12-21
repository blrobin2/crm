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

        document :update do
          action 'Assign users to territory'
        end
      end
    end
  end
end
