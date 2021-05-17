import consumer from './consumer'

const showPathRegex = /^\/chatrooms\/\d*$/

let MessagesChannel = null;

if (showPathRegex.test(window.location.pathname)) {
  const id = (window.location.pathname).match(/\d+/g)[0];
  console.log(id);
  MessagesChannel = consumer.subscriptions.create({ channel: 'MessagesChannel', id: id })
}

export default MessagesChannel;
