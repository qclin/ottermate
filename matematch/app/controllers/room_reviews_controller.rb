class RoomReviewsController < ApplicationController
  before_action :set_room_review, only: [:show, :update, :destroy]

  # GET /room_reviews
  # GET /room_reviews.json
  def index
    @room_reviews = RoomReview.all

    render json: @room_reviews
  end

  # GET /room_reviews/1
  # GET /room_reviews/1.json
  def show
    render json: @room_review
  end

  # POST /room_reviews
  # POST /room_reviews.json
  def create
    @room_review = RoomReview.new(room_review_params)

    if @room_review.save
      render json: @room_review, status: :created, location: @room_review
    else
      render json: @room_review.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /room_reviews/1
  # PATCH/PUT /room_reviews/1.json
  def update
    @room_review = RoomReview.find(params[:id])

    if @room_review.update(room_review_params)
      head :no_content
    else
      render json: @room_review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /room_reviews/1
  # DELETE /room_reviews/1.json
  def destroy
    @room_review.destroy

    head :no_content
  end

  private

    def set_room_review
      @room_review = RoomReview.find(params[:id])
    end

    def room_review_params
      params.require(:room_review).permit(:room_id, :reviewer_id, :review)
    end
end
