class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      send_confirmation_email(user)
      render json: { user_id: user.id }, status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def confirm_email
    user = User.find_by(confirm_token: params[:format])
    if user
      user.email_confirmed = true
      user.confirm_token = nil
      user.save!

      render status: :ok
    else
      render status: :not_found
    end
  end

  def send_confirmation
    user = User.find(params[:id])

    render status: :ok
    send_confirmation_email(user)
  rescue ActiveRecord::RecordNotFound
    render status: :not_found
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def send_confirmation_email(user)
    UserMailer.registration_confirmation(user).deliver_later
  end
end
