class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  private

  def not_destroyed(error)
    render json: { errors: error.record.errors }, status: :unprocessable_entity
  end
end
