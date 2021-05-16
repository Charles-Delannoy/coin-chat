import React, { Fragment } from "react"
import PropTypes from "prop-types"

const ChatWindow = ({ chatroomId }) => {
  return (
    <Fragment>
      Chatroom: {chatroomId}
    </Fragment>
  );
}

ChatWindow.propTypes = {
  chatroomId: PropTypes.number
};
export default ChatWindow
