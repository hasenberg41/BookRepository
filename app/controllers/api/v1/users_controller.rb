class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      UserMailer.registration_confirmation(user)
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
