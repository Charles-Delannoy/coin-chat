import React, { useState, useEffect, Fragment } from "react";
import UsersChannel from 'channels/users_channel';
import PropTypes from "prop-types"

const UserList = ({ current_user }) => {
  const [users, setUsers] = useState([]);
  useEffect(() => {
    UsersChannel.received = (data) => {
      const usersDiv = data.users.map((user) => {
        const statusClass = `status ${user.status.toLowerCase()}`
        const currenUserIdentifier = current_user && current_user.id === user.id ? '(Me) ' : ''
        return (
          <div key={user.id} className='user-card'>
            <div className={statusClass}></div>
            <h3>{currenUserIdentifier + user.nickname}</h3>
            <p>({user.status})</p>
          </div>
        );
      });
      setUsers(usersDiv);
    }
  })

  return (
    <Fragment>
      <div className="user-list">
        <h2>Connected Users</h2>
        {users}
      </div>
    </Fragment>
  );
}

UserList.propTypes = {
  current_user: PropTypes.object
};

export default UserList
