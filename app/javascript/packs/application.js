import "bootstrap";
import "popper.js"
import "tooltip.js"

const experienceCard = document.querySelectorAll(".experience-card");

const calendar = document.querySelector("#experiences");
const toggleActiveClass = (event) => {
  if (event.currentTarget.classList.contains('active')) {
    event.currentTarget.classList.remove('active');
  } else {
    event.currentTarget.classList.add('active');
    const id = event.currentTarget.dataset.id;
    const initialLink = calendar.getAttribute('href');
    calendar.value = calendar.value + `${id}&`
  }
  console.log(calendar)
};

const toggleActiveOnClick = (element) => {
  element.addEventListener("click", toggleActiveClass);
};
experienceCard.forEach(toggleActiveOnClick);

$(function () {
  $('[data-toggle="popover"]').popover(
  {html: true})
})
