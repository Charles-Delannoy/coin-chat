class ChatroomsController < ApplicationController
  def index
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    respond_to do |format|
      if @chatroom.save
        ActionCable.server.broadcast('chatrooms', { chatrooms: Chatroom.all })
        format.json { render json: { messages: 'Sucess' } }
      else
        format.json { render json: { messages: @chatroom.errors.messages } }
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
