class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update, :destroy]

  # GET /chats
  # GET /chats.json
  def index
    @chats = Chat.all

    render json: @chats
  end

  # GET /chats/1
  # GET /chats/1.json
  def show
    render json: @chat
  end

  # POST /chats
  # POST /chats.json
  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      render json: @chat, status: :created, location: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  # PATCH/PUT /chats/1.json
  def update
    @chat = Chat.find(params[:id])

    if @chat.update(chat_params)
      head :no_content
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  # DELETE /chats/1.json
  def destroy
    @chat.destroy

    head :no_content
  end

  private

    def set_chat
      @chat = Chat.find(params[:id])
    end

    def chat_params
      params.require(:chat).permit(:from_id, :to_id, :msg, :time, :read)
    end
end
