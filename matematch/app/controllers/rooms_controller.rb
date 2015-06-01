class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:upload,:uploadImage,:viewimage]

  def upload
    @room = Room.find(1)
  end

  def uploadImage
    room = Room.find(1)
    room.update({image: params[:file]})
    room.update({photo_url: room.image.url(:medium)})
    render json: {msg: "image received"}
  end

  def viewimage
    @room = Room.find(1)
  end

  # GET /rooms
  # GET /rooms.json
  def index
    pet = params['pet_friendly']
    neighborhood = params["neighborhood"]
    min = params["price_min"]
    max = params["price_max"]

    if neighborhood != nil && min != nil && max != nil && pet != "nil"
      @rooms = Room.where("neighborhood = ? AND price >= ? AND price <= ? AND petfriendly = ?", neighborhood, min, max, pet);
    elsif neighborhood != nil && min != nil && max != nil 
      @rooms = Room.where("neighborhood = ? AND price >= ? AND price <= ?", neighborhood, min, max);
    elsif min != nil && max != nil && pet != "nil"
      @rooms = Room.where("price >= ? AND price <= ? AND petfriendly = ?", min, max, pet);
    elsif neighborhood != nil && max != nil && pet != "nil"
      @rooms = Room.where("neighborhood = ? AND price <= ? AND petfriendly = ?", neighborhood, max, pet);
    elsif neighborhood != nil && min != nil && pet != "nil"
      @rooms = Room.where("neighborhood = ? AND price >= ? AND petfriendly = ?", neighborhood, min, pet);
    elsif neighborhood != nil && max != nil
      @rooms = Room.where("neighborhood = ? AND price <= ?", neighborhood, max);
    elsif max != nil && pet != "nil"
      @rooms = Room.where("price <= ? AND petfriendly = ?", max, pet);
    elsif neighborhood != nil && pet != "nil"
      @rooms = Room.where("neighborhood = ? AND petfriendly = ?", neighborhood, pet);
    elsif neighborhood != nil
      @rooms = Room.where("neighborhood = ?", neighborhood);
    elsif pet != "nil"
      @rooms = Room.where("petfriendly = ?", pet);
    elsif min != nil && max != nil
      @rooms = Room.where("price >= ? AND price <= ?", min, max);
    else 
      @rooms = Room.all
    end
    
    render json: @rooms
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show

    # post_params
    # @room = Room.find_by({room_id: post_params.room_id})
    user_id = @room.owner_id
    @user = User.find_by(id: user_id)
    render json: {room: @room, user: @user}
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    @room.owner_id = currentUserId
    puts currentUserId
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
