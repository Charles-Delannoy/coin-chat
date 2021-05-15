import React, { useState, useEffect, Fragment } from "react"
import ChatroomIndexChannel from 'channels/chatroom_index_channel'
// import PropTypes from "prop-types"

const ChatroomsIndex = () => {

  const [chatrooms, setChatrooms] = useState([]);

  useEffect(() => {
    ChatroomIndexChannel.received = (data) => {
      console.log(data.chatrooms);
      const rooms = data.chatrooms.map((chatroom) => {
        return (
          <a key={chatroom.id} href={`/chatrooms/${chatroom.id}`}>
            <div>
              <h2>{chatroom.name}</h2>
            </div>
          </a>
        );
      });
      setChatrooms(rooms);
    }
  }, []);

  return (
    <Fragment>
      {chatrooms}
    </Fragment>
  );
}

export default ChatroomsIndex
