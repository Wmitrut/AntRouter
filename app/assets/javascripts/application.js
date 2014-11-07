// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

$(function() {
  var map;

  initialize = function (id) {
    var latlng = new google.maps.LatLng(-26.072188, -53.038692);

    var options = {
    zoom: 15,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    map = new google.maps.Map($("#" + id)[0], options);

    var bounds = new google.maps.LatLngBounds();
    var markers = [];
    var mcOptions = {styles: [{
        height: 48,
        url: "https://cdn1.iconfinder.com/data/icons/nuvola2/48x48/apps/amor.png",
        width: 48,
        textColor: "#FFF",
        textSize: "20"
      }]
    };
    addMarkerToAddress = function(addressOrig) {
      address = encodeURI(addressOrig);
      $.getJSON('http://maps.googleapis.com/maps/api/geocode/json?address='+address+'&components=country:BR&sensor=false&field=location',
        function(data) {
          Latitude = data.results[0].geometry.location.lat;
          Longitude = data.results[0].geometry.location.lng;

          var position = new google.maps.LatLng(Latitude, Longitude);
          var marker = new google.maps.Marker({
            position: position,
            map: map,
            icon: "https://cdn1.iconfinder.com/data/icons/nuvola2/32x32/apps/package_favorite.png"
              });
          var infowindow = new google.maps.InfoWindow(), marker;
          google.maps.event.addListener(marker, 'click', (function(marker, i) {
              return function() {
            infowindow.setContent(addressOrig);
            infowindow.open(map, marker);
              }
          })(marker));
          bounds.extend(position);
          map.fitBounds(bounds);
          map.setZoom(map.getZoom());

          markers.push(marker);
          var markerCluster = new MarkerClusterer(map, markers, mcOptions);
        }
      );
    }
    google.maps.event.addDomListener(window, "resize", function() {
      google.maps.event.trigger(map, "resize");
      map.fitBounds(bounds);
      map.setZoom(map.getZoom());
      var markerCluster = new MarkerClusterer(map, markers, mcOptions);
    });
    google.maps.event.addListener(map, 'zoom_changed', function() {
      var markerCluster = new MarkerClusterer(map, markers, mcOptions);
    });
  }
});
