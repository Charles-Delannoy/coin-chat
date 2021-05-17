import React, { useState, useEffect, Fragment } from "react";
import UsersChannel from 'channels/users_channel';
import PropTypes from "prop-types"

const UserList = () => {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    UsersChannel.received = (data) => {
      console.log(data.users);
      const usersDiv = data.users.map((user) => {
        const statusClass = `status ${user.status.toLowerCase()}`
        return (
          <div key={user.id} className='user-card'>
            <div className={statusClass}></div>
            <h3>{user.nickname}</h3>
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

export default UserList
