class Api::V1::AuthenticationController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  def create
    p params.require(:password)

    user = User.find_by(username: params.require(:username))
    token = AuthenticationTokenService.call(user.id)

    render json: { 'token' => token }, status: :created
  end

  private

  def parameter_missing(err)
    render json: { error: err.message }, status: :unprocessable_entity
  end
end
