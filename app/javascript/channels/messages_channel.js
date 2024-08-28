import consumer from "channels/consumer"

consumer.subscriptions.create("MessagesChannel", {
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

document.addEventListener('DOMContentLoaded', () => {
  const patientId = document.querySelector('meta[name="patient-id"]').getAttribute('content');
  const messagesChannel = consumer.subscriptions.create(
    { channel: "MessagesChannel", patient_id: patientId },
    {
      received(data) {
        const messagesContainer = document.querySelector('#messages');
        messagesContainer.insertAdjacentHTML('beforeend', `<p><strong>${data.sender}: </strong>${data.content}</p>`);
      }
    }
  );
});
