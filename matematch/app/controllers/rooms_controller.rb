class RoomsController < ApplicationController
  before_action :set_room, only: [:show,:destroy]
  # skip_before_action :authenticate, only: [:upload,:viewimage]

  # def upload
  #   @room = Room.find(1)
  # end

  def uploadImage
    room = Room.find_by(owner_id: currentUserId)
    if room == nil
      room = Room.create({owner_id: currentUserId})
      User.find(currentUserId).update({hasRoom: true})
    end
    room.update({image: params[:file]})
    room.update({photo_url: "http://" + env['HTTP_HOST'] + room.image.url(:medium)})
    render json: {filename: room.image_file_name}
  end

  # def viewimage
  #   @room = Room.find(1)
  # end

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

  def show
    room = Room.find(params[:id])
    user = User.find(room.owner_id)
    # user = User.find_by(id: params[:id])
    # room = Room.find_by(owner_id: params[:id])
    render json: {room: room, user: user}
  end

  # POST /rooms
  # POST /rooms.json
  def create
    room = Room.find_by(owner_id: currentUserId)
    if room
      room.update(room_params)
      render json: room, status: :created, location: room
    else
      room = Room.new(room_params)
      room.owner_id = currentUserId

      if room.save
        User.find(currentUserId).update({hasRoom: true})
        render json: room, status: :created, location: room
      else
        render json: room.errors, status: :unprocessable_entity
      end
    end
  end

  private

    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:description, :price, :neighborhood, :petfriendly)
    end

end
