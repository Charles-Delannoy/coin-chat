import React, { Fragment, useEffect, useState } from "react"
import PropTypes from "prop-types"

const SingleFieldForm = ({ endPoint, fieldName, label}) => {

  const [fieldValue, setFieldValue] = useState('');
  const errorContainer = document.querySelector(".form-errors");

  const onFormSubmit = async (event) => {
    event.preventDefault();
    const bodyContent = {}
    bodyContent[fieldName] = fieldValue;
    await fetch(`${window.location.origin}/${endPoint}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': document.querySelector('[name=csrf-token]').content,
      },
      body: JSON.stringify(bodyContent),
    }).then(response => response.json())
      .then(data => {
        errorContainer.innerText = '';
        if (data.messages === 'Sucess') {
          setFieldValue('');
        } else {
          data.messages.forEach((message) => {
            errorContainer.insertAdjacentHTML('beforeend', `<p>${message}</p>`);
          });
        }
      });
  };

  return (
    <Fragment>
      <div className='form-container'>
        <form onSubmit={onFormSubmit}>
          <input placeholder='Chatroom name' type="text" name="name" value={fieldValue}
                 onChange={(event) => setFieldValue(event.target.value)}
          />
          <div className='form-errors'></div>
          <input className='form-btn' type="submit" value={label}/>
        </form>
      </div>
    </Fragment>
  );
}

export default SingleFieldForm
