import "bootstrap";




const input = document.querySelector("#friends-search");
input.addEventListener("keyup", (event) => {
  console.log(event.currentTarget.value)// what the current user typed
});


// make allt the users display none
// inside the event listener, change to display block if user name matches what the current user typed
