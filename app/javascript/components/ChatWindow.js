import React, { useState, useEffect, Fragment } from "react";
import SingleFieldForm from './SingleFieldForm';
import MessagesChannel from 'channels/messages_channel'
import PropTypes from "prop-types";

const ChatWindow = ({ chatroomId }) => {
  const endPoint = `chatrooms/${chatroomId}/messages`
  const [messages, setMessages] = useState([]);

  useEffect(() => {
    MessagesChannel.received = (data) => {
      const formattedMessages = data.messages.map((message) => {

        return (
          <div key={message.id}>
            <p>{message.content} <strong>from</strong> {message.author}</p>
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
      {messages}
    </Fragment>
  );
}

ChatWindow.propTypes = {
  chatroomId: PropTypes.number
};
export default ChatWindow
