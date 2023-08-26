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
    const room_id = document.getElementById("hidden-id").value;
    if (data.room == room_id) {
      const creator = document.getElementById('room-creator-name').innerHTML;
      const user = document.getElementById('current-user-name').innerHTML;

      if (creator == user) {
        const heroes = document.getElementById("room-heroes");
        if (data.action == 'join') {
          const html = `<label>
                            <input type="radio" value="${data.id}" name="room[hero_id]" id="room_hero_id_${data.id}">
                            ${data.name}
                            </label>`;
          heroes.insertAdjacentHTML("beforeend", html);
        }

        if (data.action == 'cancel') {
          const member_id = `room_hero_id_${data.id}`;
          document.getElementById(member_id).parentNode.remove();
        }

        const submit_btn = document.getElementById("js-submit")
        if (data.count >= 2 && submit_btn.disabled == true) {
          submit_btn.removeAttribute("disabled");
        } else if (data.count < 2 && submit_btn.disabled == false) {
          submit_btn.setAttribute("disabled", true);
        }

      } else {

        const members = document.getElementById("members");
        if (data.action == 'join') {

          const html = `<li id="member-${data.id}">
                    ${data.name}
                    </li>`;
          members.insertAdjacentHTML("beforeend", html);

        }

        if (data.action == 'cancel') {
          const member_id = `member-${data.id}`;
          document.getElementById(member_id).remove();
        }

      }

      document.getElementById("total_members").innerHTML = data.count;
    }

  }
});
