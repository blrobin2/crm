class TerritorySerializer < BaseSerializer
  set_type :territories

  attribute :name do |object|
    object.name.titleize.upcase
  end
  attribute :parent_id
  attribute :child_ids
  attribute :advisor_name
  attribute :sales_person_name

  belongs_to :advisor, serializer: UserSerializer
  belongs_to :sales, serializer: UserSerializer
end
