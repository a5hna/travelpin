var map;
  const experiences = document.querySelectorAll('.experience-card')
  const mapElement = document.getElementById('map')
  const centerCoords = JSON.parse(mapElement.dataset.center)
  const markers = JSON.parse(mapElement.dataset.markers)
  let mapCenter = new google.maps.LatLng(centerCoords[0], centerCoords[1]);
  map = new google.maps.Map(
    document.getElementById('map'), {
      center: mapCenter,
      zoom: 12
    });

  google.maps.event.addListener(map, 'click', function(event) {
    placeMarker(event.latLng);
    function openModal(){document.getElementById('add-experience-link').click()}
    setTimeout(openModal, 1000);
  });

  var ownMarker;
  function placeMarker(location) {
    if (ownMarker) {
      ownMarker.setPosition(location);
    } else {
      ownMarker = new google.maps.Marker({
        position: location,
        map: map,
        draggable: true,
        animation: google.maps.Animation.DROP
      });
    }
  }

  markers.forEach(function(pin, i) {
    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(pin[0], pin[1]),
      map: map,
      icon: "/assets/_triangle-marker.svg",
      draggable: true
    });
    marker.addListener('mouseover', (event) => {
      experiences[i].classList.add('selected')
    });
    marker.addListener('mouseout', (event) => {
      experiences[i].classList.remove('selected')
    });
    marker.addListener('click', (event) => {
      console.log(i);
      console.log(experiences[i])
      console.log(experiences)
    });
  });
