class UserEndorsementsController < ApplicationController
  before_action :set_user_endorsement, only: [:show, :update, :destroy]

  # GET /user_endorsements
  # GET /user_endorsements.json
  def index
    @user_endorsements = UserEndorsement.all

    render json: @user_endorsements
  end

  # GET /user_endorsements/1
  # GET /user_endorsements/1.json
  def show
    render json: @user_endorsement
  end

  # POST /user_endorsements
  # POST /user_endorsements.json
  def create
    @user_endorsement = UserEndorsement.new(user_endorsement_params)

    if @user_endorsement.save
      render json: @user_endorsement, status: :created, location: @user_endorsement
    else
      render json: @user_endorsement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_endorsements/1
  # PATCH/PUT /user_endorsements/1.json
  def update
    @user_endorsement = UserEndorsement.find(params[:id])

    if @user_endorsement.update(user_endorsement_params)
      head :no_content
    else
      render json: @user_endorsement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_endorsements/1
  # DELETE /user_endorsements/1.json
  def destroy
    @user_endorsement.destroy

    head :no_content
  end

  private

    def set_user_endorsement
      @user_endorsement = UserEndorsement.find(params[:id])
    end

    def user_endorsement_params
      params.require(:user_endorsement).permit(:endorser_id, :endorsee_id, :skill)
    end
end
