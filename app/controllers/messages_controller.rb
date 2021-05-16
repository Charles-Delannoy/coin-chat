class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.author = @current_user.nickname
    if @message.save
      ActionCable.server.broadcast("chatroom-#{@chatroom.id}", { messages: Message.where(chatroom_id: @chatroom.id) })
      render json: { messages: 'Sucess' }
    else
      render json: { messages: @message.errors.messages[:content] }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
