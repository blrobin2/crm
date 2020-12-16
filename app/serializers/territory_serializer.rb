class TerritorySerializer < BaseSerializer
  set_type :territories

  attribute :name
  belongs_to :advisor, serializer: UserSerializer
  belongs_to :sales, serializer: UserSerializer
end
