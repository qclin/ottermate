class CurrentUsersController < ApplicationController

  def show
    render json: User.find(currentUserId)
  end

  def update
    @user = User.find(currentUserId)
    if @user.update(user_params)
      render json: User.find(currentUserId)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  def user_params
      params.require(:user).permit(:name, :budget, :gender, :hasRoom, :personality, :occupation, :email, :phone, :description)
  end

end