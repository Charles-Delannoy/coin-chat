import React, { Fragment, useEffect, useState } from "react"
import PropTypes from "prop-types"

const ChatroomForm = () => {

  const [name, setName] = useState('');
  const errorContainer = document.querySelector(".form-errors");

  const onFormSubmit = async (event) => {
    event.preventDefault();
    console.log(JSON.stringify({ name }));
    await fetch(`${window.location.origin}/chatrooms`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': document.querySelector('[name=csrf-token]').content,
      },
      body: JSON.stringify({ name }),
    }).then(response => response.json())
      .then(data => {
        errorContainer.innerText = '';
        if (data.messages.name) {
          data.messages.name.forEach((message) => {
            errorContainer.insertAdjacentHTML('beforeend', `<p>${data.messages.name}</p>`);
          });
        } else {
          setName('');
        }
      });
  };

  return (
    <Fragment>
      <div className='form-container'>
        <form onSubmit={onFormSubmit}>
          <input placeholder='Chatroom name' type="text" name="name" value={name}
                 onChange={(event) => setName(event.target.value)}
          />
          <div className='form-errors'></div>
          <input className='form-btn' type="submit" value="Create Chatroom"/>
        </form>
      </div>
    </Fragment>
  );
}

export default ChatroomForm
