import "bootstrap";
import "popper.js"
import "tooltip.js"

const experienceCard = document.querySelectorAll(".experience-card");

const notificationCount = document.getElementById("notification");

const calendar = document.querySelector("#experiences");
const toggleActiveClass = (event) => {
  const boardShowPage = document.getElementById('board-show');

  if (boardShowPage) {
    if (event.currentTarget.classList.contains('active')) {console.log(notificationCount)
      event.currentTarget.classList.remove('active');
      notificationCount.innerText = Number.parseInt(notificationCount.innerText, 10) - 1
      if (Number.parseInt(notificationCount.innerText, 10) === 0 ) {
        notificationCount.style.display = "none"
      }
    } else  {
        notificationCount.style.display = "flex"


      event.currentTarget.classList.add('active');
      const id = event.currentTarget.dataset.id;
      const initialLink = calendar.getAttribute('href');
      calendar.value = calendar.value + `${id}&`
      notificationCount.innerText = Number.parseInt(notificationCount.innerText, 10) + 1
      }
    }
  }
;

const toggleActiveOnClick = (element) => {
  element.addEventListener("click", toggleActiveClass);
};

experienceCard.forEach(toggleActiveOnClick);

$(function () {
  var form　= $('.popover-div')
  var title = '<h1>haha</h1>'
  var button = '<button type="button" id="example" class="btn btn-primary">example</button>'
  var myimg = "<img src='//tutorialsplane.com/wp-content/uploads/2016/03/CaptureAdmin.png' height='200px' width='200px'>";
  $('[data-toggle="popover"]').popover({
    html: true,
    placement: 'top',
    content: form
  })
})
