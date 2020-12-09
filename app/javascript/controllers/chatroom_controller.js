import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = ["chatContainer", "message"]

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
    });
  };

  closeBox(e) {
    this.chatContainerTarget.innerHTML = "";
  }

  // sendMessage (e) {
  //   e.preventDefault()
  //   const chatroomId = e.currentTarget.dataset.chatroom_id
  //   console.log(chatroomId)
  //   const mes = this.messageTarget.value;
  //   fetchWithToken(`/chatrooms/${chatroomId}/messages`, {
  //     method: "POST",
  //     headers: {
  //       "Accept": "application/json",
  //       "Content-Type": "application/json"
  //     },
  //     body: JSON.stringify({ message: { content: mes } })
  //   });
  //     // .then(res => res.json())
  //     // .then(data => {
  //     //   console.log(data)
  //     // });
  // }

}
