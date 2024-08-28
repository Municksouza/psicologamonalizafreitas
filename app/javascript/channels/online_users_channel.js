import consumer from "channels/consumer"

consumer.subscriptions.create("OnlineUsersChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  }
});

import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', () => {
  const onlineUsersContainer = document.querySelector('#online-users');

  consumer.subscriptions.create("OnlineUsersChannel", {
    received(data) {
      if (data.status === 'online') {
        onlineUsersContainer.insertAdjacentHTML('beforeend', `<p>${data.user} is online</p>`);
      } else {
        const userElement = Array.from(onlineUsersContainer.querySelectorAll('p'))
                                  .find(p => p.textContent.includes(data.user));
        if (userElement) userElement.remove();
      }
    }
  });
});
