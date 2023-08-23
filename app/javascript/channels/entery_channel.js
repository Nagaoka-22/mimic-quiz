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
    const heroes = document.getElementById("room-heroes");
    if (heroes != null) {
      if (data.name != null) {
        const html = `<label>
                      <input type="radio" value="${data.id}" name="room[hero_id]" id="room_hero_id_${data.id}">
                      ${data.name}
                      </label>`;
        heroes.insertAdjacentHTML("beforeend", html);
      } else {
        const member = `room_hero_id_${data.id}`;
        document.getElementById(member).parentNode.remove();
      }
      const total_members = heroes.getElementsByTagName("label").length;
      document.getElementById("total_members").innerHTML = total_members;
      const submit_btn = document.getElementById("js-submit")
      if (total_members >= 2 && submit_btn.disabled == true) {
        submit_btn.removeAttribute("disabled");
      } else if (total_members < 2 && submit_btn.disabled == false) {
        submit_btn.setAttribute("disabled", true);
      }
    }

    const members = document.getElementById("members");
    if (members != null) {
      if (data.name != null) {
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
  }
});
