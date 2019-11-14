     var map;
    const experiences = document.querySelectorAll('.experience-card')
    const mapElement = document.getElementById('map')
    const centerCoords = JSON.parse(mapElement.dataset.center)
    const markers = JSON.parse(mapElement.dataset.markers)
    const location = document.getElementById('exp-location')
    const formLat = document.getElementById('formLat')
    const formLng = document.getElementById('formLng')
    const limite = JSON.parse(mapElement.dataset.bounds)
    const ne_bound = new google.maps.LatLng(limite[0][0], limite[0][1])
    const sw_bound = new google.maps.LatLng(limite[1][0], limite[1][1])
    const bounds = new google.maps.LatLngBounds(sw_bound, ne_bound)
    const { greenMarker, pinDropMarker } = mapElement.dataset;

    let mapCenter = new google.maps.LatLng(centerCoords[0], centerCoords[1]);
    map = new google.maps.Map(
      document.getElementById('map'), {
        center: mapCenter,
        zoom: 10,
        disableDefaultUI: true,
        mapTypeId: 'terrain'
      });
    map.fitBounds(bounds, -100);

    map2 = new google.maps.Map(
      document.getElementById('small-map'), {
        center: mapCenter,
        zoom: 12,
        disableDefaultUI: true,
        mapTypeId: 'terrain'
      });
    map2.fitBounds(bounds, -100);

    google.maps.event.addListener(map2, 'click', function(event) {
      placeMarker(event.latLng);
      console.log(event.latLng.lat());
      console.log(event.latLng.lng());
      location.value = `${event.latLng.lat()},${event.latLng.lng()} `
      formLat.value = event.latLng.lat();
      formLng.value = event.latLng.lng();
    });
    var marker2;
    function placeMarker(location) {
      if (marker2) {
        marker2.setPosition(location);
      } else {
          marker2 = new google.maps.Marker({
          position: location,
          map: map2,
          icon: pinDropMarker,
          draggable: true,
          animation: google.maps.Animation.DROP
        });
      }}
      markers.forEach(function(pin, i) {
        var marker = new google.maps.Marker({
          position: new google.maps.LatLng(pin[0], pin[1]),
          map: map,
          icon: greenMarker,
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

