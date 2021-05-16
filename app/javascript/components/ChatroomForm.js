import React, { Fragment } from "react"
import PropTypes from "prop-types"
const ChatroomForm = () => {
    return (
      <Fragment>
        <div className='form-container'>
          <form>
            <input placeholder='Chatroom name' type="text" name="name" />
            <input className='form-btn'type="submit" value="Create Chatroom" />
          </form>
        </div>
      </Fragment>
    );
}

export default ChatroomForm
