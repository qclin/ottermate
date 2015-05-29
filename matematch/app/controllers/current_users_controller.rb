class CurrentUsersController < ApplicationController

  def show
    render json: User.find(currentUserId)
  end

  def update
    @user = User.find(currentUserId)
    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  def user_params
      params.require(:user).permit(:name, :username, :budget, :gender, :hasRoom, :personality, :occupation, :email, :phone, :password)
  end

end