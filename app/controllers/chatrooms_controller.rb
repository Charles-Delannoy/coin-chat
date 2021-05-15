class ChatroomsController < ApplicationController
  def index
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      ActionCable.server.broadcast('chatrooms', { chatrooms: Chatroom.all })
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    @chatroom = Chatroom.find(params[:id])
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end
