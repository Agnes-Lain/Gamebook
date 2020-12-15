const initFriendshipBtn = () => {
  const friendshipBtns = document.querySelectorAll('.add-friend');
  if (friendshipBtns) {
    friendshipBtns.forEach(btn =>
      btn.addEventListener("click", (event)=>{
        if (btn.classList.contains("fa-user-plus")) {
          btn.classList.remove("fa-user-plus");
          btn.classList.add("fa-user-times");
        } else {
          btn.classList.remove("fa-user-times");
          btn.classList.add("fa-user-plus");
        }

      })
    )
  }
}

export { initFriendshipBtn };
