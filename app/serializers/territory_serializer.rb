class TerritorySerializer < BaseSerializer
  set_type :territories

  attribute :name do |object|
    object.name.titleize.upcase
  end
  attribute :parent_id
  belongs_to :advisor, serializer: UserSerializer
  belongs_to :sales, serializer: UserSerializer

  attribute :child_ids
end
