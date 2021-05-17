import React, { useState, Fragment } from "react"
import PropTypes from "prop-types"
const StatusForm = ({ user }) => {

  const [status, setStatus] = useState(['Available', 'Busy', 'Away'])
  const [selected, setSelected] = useState(user.status)

  const options = status.map((state) => {
    return (
      <option key={state} value={state}>{state}</option>
    );
  });

  const onSelectChange = async (event) => {
    const state = event.target.value;
    setSelected(state);
    await fetch(`${window.location.origin}/users/${user.id}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': document.querySelector('[name=csrf-token]').content,
      },
      body: JSON.stringify({ status: state }),
    })
  }

  return (
    <Fragment>
      <select defaultValue={selected} onChange={onSelectChange} className={selected.toLowerCase()}>
        {options}
      </select>
    </Fragment>
  );
}

StatusForm.propTypes = {
  user: PropTypes.object
};

export default StatusForm
