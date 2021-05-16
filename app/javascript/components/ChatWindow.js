import React, { Fragment } from "react";
import SingleFieldForm from './SingleFieldForm';
import PropTypes from "prop-types";

const ChatWindow = ({ chatroomId }) => {
  const endPoint = `chatrooms/${chatroomId}/messages`
  return (
    <Fragment>
      <SingleFieldForm
        endPoint={endPoint}
        fieldName='content'
        label='Send Message'
        placeHolder='Type your message'
      />
    </Fragment>
  );
}

ChatWindow.propTypes = {
  chatroomId: PropTypes.number
};
export default ChatWindow
