class Api::V1::AuthenticationController < ApplicationController
  class AuthenticationError < StandardError; end

  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from AuthenticationError, with: :password_incorrect

  def create
    raise AuthenticationError unless user.authenticate(params.require(:password))
    token = AuthenticationTokenService.call(user.id)

    render json: { 'token' => token }, status: :created
  end

  private

  def user
    @user ||= User.find_by(username: params.require(:username))
  end

  def parameter_missing(err)
    render json: { error: err.message }, status: :unprocessable_entity
  end

  def password_incorrect
    head :unauthorized
  end
end
