class ChatroomsController < ApplicationController
  def index
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      ActionCable.server.broadcast('chatrooms', { chatrooms: Chatroom.all })
      render json: { messages: 'Sucess' }
    else
      render json: { messages: @chatroom.errors.messages[:name] }
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
