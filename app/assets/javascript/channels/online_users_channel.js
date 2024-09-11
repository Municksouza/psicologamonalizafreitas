// app/javascript/channels/online_users_channel.js
import consumer from "./consumer"

consumer.subscriptions.create("OnlineUsersChannel", {
  received(data) {
    // Atualize a interface do usuário com o status online/offline
    console.log(`User ${data.user} is now ${data.status}`);
  }
});
