class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      UserMailer.registration_confirmation(user).deliver_later
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def confirm_email
    debugger
    user = User.find_by()
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
