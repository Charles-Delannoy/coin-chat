import React, { useState, useEffect, Fragment } from "react";
import ChatroomIndexChannel from 'channels/chatroom_index_channel';
import SingleFieldForm from './SingleFieldForm';
import SearchBar from './SearchBar'
// import PropTypes from "prop-types";

const ChatroomsIndex = () => {

  const [query, setQuery] = useState('');
  const [timedQuery, setTimedQuery] = useState(query);
  const [roomsData, setRoomsData] = useState([]);
  const [chatrooms, setChatrooms] = useState([]);

  useEffect(() => {
    ChatroomIndexChannel.received = (data) => {
      setRoomsData(data.chatrooms);
      setQuery('');
    }
  }, []);

  useEffect(() => {
    const timerId = setTimeout(() => {
      setTimedQuery(query.toLowerCase());
    }, 1000);

    return () => {
      clearTimeout(timerId);
    };
  }, [query]);

  useEffect(() => {
    let datas = roomsData
    if (timedQuery) {
      console.log(timedQuery)
      datas = roomsData.filter((chatroom) => {
        return chatroom.name.toLowerCase().includes(timedQuery);
      });
    }
    const rooms = datas.map((chatroom) => {
      return (
        <a className='chatroom-card' key={chatroom.id} href={`/chatrooms/${chatroom.id}`}>
          <div>
            <h2>{chatroom.name}</h2>
          </div>
        </a>
      );
    });
    setChatrooms(rooms);
  }, [timedQuery, roomsData])

  return (
    <Fragment>
      <SingleFieldForm
        endPoint='chatrooms'
        fieldName='name'
        label='Create Chatroom'
        placeHolder='Chatroom name'
      />
      <div className='searchbar-container'>
        <SearchBar term={query} setTerm={setQuery} />
      </div>
      <div className='chatrooms-container'>
        {chatrooms}
      </div>
    </Fragment>
  );
}

export default ChatroomsIndex
