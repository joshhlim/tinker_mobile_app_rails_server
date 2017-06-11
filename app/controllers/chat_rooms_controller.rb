class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.all
    # client = Instagram.client(:access_token => session[:access_token])
    #     response = client.user_recent_media
    #     album = [].concat(response)
    #     max_id = response.pagination.next_max_id

    #     while !(max_id.to_s.empty?) do
    #         response = client.user_recent_media(:max_id => max_id)
    #         max_id = response.pagination.next_max_id
    #         album.concat(response)
    #     end
    #     @album = album
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new

    @client = Instagram.client(:access_token => session[:access_token])
    @user = @client.user
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end
