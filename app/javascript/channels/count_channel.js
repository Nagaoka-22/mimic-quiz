import consumer from "./consumer"

consumer.subscriptions.create("CountChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const room_id = document.getElementById("hidden-id").value;
    if (data.room == room_id) {
      if (data.action == "answer") {
        document.getElementById("total_answers").innerHTML = data.count;
      }
      if (data.action == "vote") {
        document.getElementById("total_votes").innerHTML = data.count;
      }
      var denominator = document.getElementById("denominator").innerHTML;
      var jsCount = document.getElementById("js-count");
      if (denominator == data.count) {
        jsCount.classList.add("ready");
      }

    }
  }
});
