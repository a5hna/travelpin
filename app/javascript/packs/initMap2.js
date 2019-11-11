     var map;
    const experiences = document.querySelectorAll('.experience-card')
    const mapElement = document.getElementById('map')
    const centerCoords = JSON.parse(mapElement.dataset.center)
    const markers = JSON.parse(mapElement.dataset.markers)
    const location = document.getElementById('exp-location')
    const formLat = document.getElementById('experience_latitude')
    const formLng = document.getElementById('experience_longitude')
    let mapCenter = new google.maps.LatLng(centerCoords[0], centerCoords[1]);
    map = new google.maps.Map(
      document.getElementById('map'), {
        center: mapCenter,
        zoom: 10
      });

    map2 = new google.maps.Map(
      document.getElementById('small-map'), {
        center: mapCenter,
        zoom: 12
      });
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
          icon: "/assets/_triangle-marker.svg",
          draggable: true,
          animation: google.maps.Animation.DROP
        });
      }}
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

