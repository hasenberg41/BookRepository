require 'jwt'
require 'json'

class AuthenticationTokenService
  ALGORITHM_TYPE = 'HS256'.freeze

  def self.call(user_id)
    payload = { 'user_id' => user_id }

    JWT.encode payload, secret_key, ALGORITHM_TYPE
  end

  def self.decode(token)
    decoded_token = JWT.decode token, secret_key, true, { algorithm: ALGORITHM_TYPE }
    decoded_token[0]['user_id']
  rescue JWT::DecodeError
    raise ActiveRecord::RecordNotFound
  end

  def self.secret_key
    Rails.application.secrets.secret_key_base.to_s
  end
end
