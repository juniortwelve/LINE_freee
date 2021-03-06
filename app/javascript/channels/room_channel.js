import consumer from "./consumer"

$(function () {
  const chatChannel = consumer.subscriptions.create({ channel: 'RoomChannel', room: $('#messages').data('room_id') }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received: function(data) {
      console.log(data);
      return $('#messages').append(data['message']);
    },

    speak: function(message) {
      console.log(message);
      return this.perform('speak', {
        message: message
      });
    }
  });

  $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
    if (event.keyCode == 13) {
      chatChannel.speak(event.target.value);
      event.target.value = '';
      return event.preventDefault();
    }
  });
});


