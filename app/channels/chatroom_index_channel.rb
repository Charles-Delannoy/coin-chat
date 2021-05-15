class ChatroomIndexChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chatrooms'

    ActionCable.server.broadcast('chatrooms', { chatrooms: Chatroom.all })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
