const initMap = () => {
  console.log(google)
  var map;

  map = new google.maps.Map(
    document.getElementById('map'), {
      center: new google.maps.LatLng(JSON.parse(map.dataset.center)),
      zoom: 12
    });
  const experiences = document.querySelectorAll('.experience-card')
  const markers = JSON.parse(map.dataset.markers);
  markers.forEach((each) => {
    let i = 0
    let marker = new google.maps.Marker({
    position: new google.maps.LatLng(each.lat, each.lng),
    map: map
    });
    marker.addListener('mouseover', (event) => {
    experiences[i].classList.add('selected')
  });
  marker.addListener('mouseout', (event) => {
    experiences[i].classList.remove('selected')
  });
  marker.addListener('click', (event) => {
    console.log(event);
  });
  i += 1
  });
  var controlDiv = document.querySelector('.control-div');
  controlDiv.index = 1;
  map.controls[google.maps.ControlPosition.BOTTOM_CENTER].push(controlDiv);
}



