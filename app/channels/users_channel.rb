class UsersChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'users'

    ActionCable.server.broadcast('users', { users: User.order(nickname: :asc) })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
