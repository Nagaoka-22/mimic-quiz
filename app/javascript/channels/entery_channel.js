import consumer from "./consumer"

consumer.subscriptions.create("EnteryChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const members = document.getElementById("members");
    if(data.name != null) {
      const html = `<li id="member-${data.id}">
                    ${data.name}
                    </li>`;
      members.insertAdjacentHTML("beforeend", html);
    } else {
      const member = `member-${data.id}`;
      document.getElementById(member).remove();
    }
    const total_members = members.getElementsByTagName("li").length;
    document.getElementById("total_members").innerHTML = total_members;
  }
});
