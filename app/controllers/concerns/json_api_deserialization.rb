module JsonApiDeserialization
  extend ActiveSupport::Concern

  def valid_jsonapi?
    Crm::Request.new(request).valid?
  end
end
