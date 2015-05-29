class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:create]

  # GET /users
  # GET /users.json
  def index
    #@users = User.all
    min = params["budget"].to_i - params["range"].to_i
    max = params["budget"].to_i + params["range"].to_i
    
    @users = User.where("hasRoom = ? AND gender = ? AND description LIKE ? AND budget >= ? AND budget <= ?", false, params["gender"].downcase, params["description"], min,max);
    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)


    if @user.save
      # render json: {token: makeToken(@user.id)}
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

 

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    head :no_content
  end


  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :username, :budget, :gender, :hasRoom, :personality, :occupation, :email, :phone, :password, :description)
    end
end
