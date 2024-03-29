module Crm
  class BaseQuery
    include Concerns::Filter
    include Concerns::Group
    include Concerns::Include
    include Concerns::Join
    include Concerns::Pagination
    include Concerns::Select
    include Concerns::Scope
    include Concerns::Sort

    attr_reader :user, :params

    def initialize(user, params)
      @user = user
      @params = params.permit!.to_h
    end

    def all
      all_without_pagination.page(page_number).per(page_size)
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def all_without_pagination
      @all_without_pagination ||=
        scope
        .includes(include_conditions)
        .includes(join_conditions)
        .select(select_conditions)
        .where(scopes)
        .where(wheres)
        .then do |relation|
          filters.reduce(relation) { |rel, filter| rel.where(filter) }
        end
        .group(group_conditions)
        .order(sort_conditions)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def find(id = nil, by: :id)
      scope.find_by!(by => id || params[:id])
    end

    def scope(scope)
      "#{scope}Policy".constantize::Scope.new(user, scope).resolve
    end
  end
end
