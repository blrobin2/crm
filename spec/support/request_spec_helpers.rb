# frozen_string_literal: true

module RequestSpecHelpers
  def decode_token(token)
    JWTSerializer.decode(token)
  end
end
