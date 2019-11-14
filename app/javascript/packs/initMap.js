var map;
  const experiences = document.querySelectorAll('.experience-card')
  const mapElement = document.getElementById('map')
  const centerCoords = JSON.parse(mapElement.dataset.center)
  const markers = JSON.parse(mapElement.dataset.markers)
  const places = JSON.parse(mapElement.dataset.places)
  const limite = JSON.parse(mapElement.dataset.bounds)
  const ne_bound = new google.maps.LatLng(limite[0][0], limite[0][1])
  const sw_bound = new google.maps.LatLng(limite[1][0], limite[1][1])
  const bounds = new google.maps.LatLngBounds(sw_bound, ne_bound)

  let mapCenter = new google.maps.LatLng(centerCoords[0], centerCoords[1]);
  map = new google.maps.Map(
    document.getElementById('map'), {
      center: mapCenter,
      zoom: 12,
      disableDefaultUI: true,
      mapTypeId: 'terrain'
    });
  map.fitBounds(bounds, -100);

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
        icon: '/assets/pin-drop-marker.svg',
        animation: google.maps.Animation.DROP
      });
    }
  }

  places.forEach(function(pin, i) {
    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(pin.coords[0], pin.coords[1]),
      map: map,
      icon: `/assets/triangle${pin.category_id}.svg`,
    });
    marker.addListener('mouseover', (event) => {
      experiences[i].classList.add('selected')
    });
    marker.addListener('mouseout', (event) => {
      experiences[i].classList.remove('selected')
    });
    marker.addListener('click', (event) => {
      document.getElementById(`button${pin.id}`).click()
    });
  });
