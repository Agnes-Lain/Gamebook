import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = ["chatContainer"]

  initChatroom(e) {
    const friendUserId = e.currentTarget.dataset.friend
    async function createChatroom (friendUserId) {
      const chatroom = await fetchWithToken("/chatrooms", {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ friend_user_id: friendUserId })
      });
      const response = await chatroom.json()

      if (response.success) {
        const chatroomUsers = await fetchWithToken(`/chatrooms/${response.chatroom_id}/chatroom_users`, {
          method: "POST",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: JSON.stringify({ friends:{friend_user_id: friendUserId } })
        });
        const res = await chatroomUsers.json();
        return res
      } else {
        return response
      }

    };

   createChatroom(friendUserId)
    .then(data => {
      this.chatContainerTarget.innerHTML = data.chatroom_html;
      const messageBox = document.getElementById("messages");
      messageBox.scrollTo(0, messageBox.scrollHeight);
    });

    // const messages = this.mesShowTarges;
    // messages.forEach (message => {
    //   if message
    // })
  };

  closeBox() {
    this.chatContainerTarget.innerHTML = "";
  }

}
