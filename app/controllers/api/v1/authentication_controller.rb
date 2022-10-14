class Api::V1::AuthenticationController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  def create
    p params.require(:username)
    p params.require(:password)

    render json: { 'token' => 'this_is_test_token' }, status: :created
  end

  private

  def parameter_missing(err)
    render json: { error: err.message }, status: :unprocessable_entity
  end
end
