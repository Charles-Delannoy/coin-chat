import consumer from './consumer'

let ChatroomIndexChannel = null;

if (window.location.pathname === '/' || '/chatrooms') {
  ChatroomIndexChannel = consumer.subscriptions.create('ChatroomIndexChannel');
}

export default ChatroomIndexChannel
