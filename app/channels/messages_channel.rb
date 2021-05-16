class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    chatroom = Chatroom.find(params[:id])
    stream_from "chatroom-#{params[:id]}"

    ActionCable.server.broadcast("chatroom-#{params[:id]}", messages: Message.where(chatroom_id: chatroom.id))
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
