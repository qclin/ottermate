class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    # @rooms = Room.all
    params = JSON.parse(params[:search])
    binding.pry
    range = [params["price_min"] .. params["price_max"]]
    @rooms = Room.where({neighborhood: params["neighborhood"], price: in:range, pet_friendly: params["pet_friendly"]})
    render json: @rooms
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    render json: @room
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    if @room.save
      render json: @room, status: :created, location: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    @room = Room.find(params[:id])

    if @room.update(room_params)
      head :no_content
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy

    head :no_content
  end

  private

    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:description, :price, :photo_url, :neighborhood, :petfriendly)
    end

end
