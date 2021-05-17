import React, { useState, useEffect, Fragment } from "react";
import SingleFieldForm from './SingleFieldForm';
import MessagesChannel from 'channels/messages_channel'
import PropTypes from "prop-types";

const ChatWindow = ({ chatroomId }) => {
  const endPoint = `chatrooms/${chatroomId}/messages`
  const [messages, setMessages] = useState([]);

  useEffect(() => {
    MessagesChannel.received = (data) => {
      console.log(data.messages);
      const formattedMessages = data.messages.map((message) => {
        console.log(message.created_at)
        return (
          <div className='message' key={message.id}>
            <h3>{message.author}</h3>
            <p>{message.content}</p>

          </div>
        );
      });
      setMessages(formattedMessages);
    }
  }, []);

  return (
    <Fragment>
      <SingleFieldForm
        endPoint={endPoint}
        fieldName='content'
        label='Send Message'
        placeHolder='Type your message'
      />
      <div className='messages-container'>
        {messages}
      </div>
    </Fragment>
  );
}

ChatWindow.propTypes = {
  chatroomId: PropTypes.number
};
export default ChatWindow
