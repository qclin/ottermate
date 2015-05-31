class ChatsController < ApplicationController

  # GET /chats
  # GET /chats.json
  # returns a list of all users that have chatted with the current user
  def index
    toids = Chat.select(:to_id).distinct.where(:from_id => currentUserId).map {|chat| chat.to_id}
    fromids = Chat.select(:from_id).distinct.where(:to_id => currentUserId).map {|chat| chat.from_id}

    # make sure we have some chat userids before we access the usernames
    if (toids.length + fromids.length > 0)
      users = User.where(:id => toids+fromids)
    #   # render array of usernames
    #   render json: users.map{|u| u.username}
      render json: users.map {|u| u.name}
    else
      # render empty array
      render json: []
    end
  end

  # retrieve all chats between current user and user 'username'
  # GET /chats/username
  def show
    username = params[:id]
    user1 = User.find(currentUserId)
    user2 = User.find_by({name: username})
    chats = Chat.select(:from_id,:msg).where("(from_id = ? AND to_id = ?) OR (from_id = ? AND to_id = ?)", currentUserId, user2.id, user2.id, currentUserId).order(created_at: :desc)
    formattedmessages = chats.map do |chat|
      if (chat.from_id == currentUserId)
        {:username => user1.name, :msg => chat.msg}
      else
        {:username => user2.name, :msg => chat.msg}
      end
    end
    render json: formattedmessages
    # render json: {test: "test"}
  end

  # add message from current user to user params[:to_username]
  # POST /chats
  def create
    to_user = User.find_by(name: params[:to_username])

    chat = Chat.new(msg: params[:message], from_id: currentUserId, to_id: to_user.id, read: false)

    if chat.save

      # evan, i'm appending the msg to watson text here 
      currentUser = User.find(currentUserId)
      updated_watsonfeed = currentUser.watsonfeed + " \n " + params[:message] 
      
      currentUser.update({ watsonfeed: updated_watsonfeed, personality: nil})
      render json: {sent: true}
    else
      render json: chat.errors, status: :unprocessable_entity
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

    def chat_params
      params.require(:chat).permit(:from_id, :to_id, :msg, :time, :read)
    end
end
