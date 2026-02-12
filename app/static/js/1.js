document.addEventListener("DOMContentLoaded", () => {
    var routeStops = [];
    var routeMarkers = [];
    var routeLine = null;
    let routeJsonView = [];
    const colors = ["blue","purple", "yellow", "orange", "black", "white",];


    const stops = window.STOPS;
    const bus = window.BUS;
    let json_cont = document.getElementById("jsonData");

    var map = L.map('map').setView([51.6755, 39.2089], 13);

    L.tileLayer('/tiles/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap contributors',
      minZoom: 12,
      maxZoom: 15
    }).addTo(map);

//    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',).addTo(map);
    let routeLayerGroup = L.featureGroup().addTo(map);

    async function searchRoute() {
      const start = document.getElementById("start").value;
      const end = document.getElementById("end").value;

      if (start != end) {
        const response = await fetch(`/api/search?start=${start}&stop=${end}`);
        const data = await response.json();

        routeLayerGroup.clearLayers();
        const routes = data.result.routes;
        delete data.result.routes;

        renderJson(data.result);

        let colorIndex = 0;

        const routeEntries = Object.entries(routes);

        const firstSegmentStops = routeEntries[0][1];
        const lastSegmentStops = routeEntries[routeEntries.length - 1][1];

        const startStop = firstSegmentStops[0];
        const endStop = lastSegmentStops[lastSegmentStops.length - 1];

        Object.entries(routes).forEach(([busName, stops]) => {
            const latlngs = stops.map(s => [s.lat, s.lon]);

            // Линия маршрута
            const polyline = L.polyline(latlngs, { color: colors[colorIndex % colors.length], weight: 6 });
            polyline.addTo(routeLayerGroup);
            polyline.bindPopup(busName);

            // Точки остановок
            stops.forEach(stop => {
              L.circleMarker([stop.lat, stop.lon], { radius: 5, color: colors[colorIndex % colors.length] })
                .addTo(routeLayerGroup)
                .bindTooltip(stop.name, { permanent: false });
            });

            colorIndex++;
          });

            L.circleMarker([startStop.lat, startStop.lon], {
              radius: 10,              // БОЛЬШЕ обычных
              color: "#1abc9c",
              fillColor: "#1abc9c",
              fillOpacity: 1,
              weight: 2
            })
            .addTo(routeLayerGroup)
            .bindTooltip(
              `Старт: ${startStop.name}`,
              {
                permanent: true,
                direction: "right",
                offset: [15, 0],
                className: "start-tooltip"
              }
            );

            L.circleMarker([endStop.lat, endStop.lon], {
              radius: 12,              // ещё чуть больше
              color: "#e74c3c",
              fillColor: "#e74c3c",
              fillOpacity: 1,
              weight: 2
            })
            .addTo(routeLayerGroup)
            .bindTooltip(
              `Финиш: ${endStop.name}`,
              {
                permanent: true,
                direction: "left",
                offset: [-15, 0],
                className: "end-tooltip"
              }
            );

            map.fitBounds(routeLayerGroup.getBounds(), {
              padding: [40, 40]
            });
      }
      else { renderJson("Выберете разные остановки"); }
    };

    async function viewRoute() {
      const doc_obj = document.getElementById("view_route");
      const id_obj = doc_obj.value;
      const name_obj = doc_obj.options[doc_obj.selectedIndex].text;

      const response = await fetch("/api/bus_view", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: id_obj, name: name_obj })
      });
      const data = await response.json();

      let colorIndex = 0;

      renderJson(data);

      routeLayerGroup.clearLayers();

      data.result.forEach(route => {
        const stops = route.stops;
        const latlngs = stops.map(s => [s.lat, s.lon]);
        const polyline = L.polyline(latlngs, { color: colors[colorIndex % colors.length], weight: 6 }).addTo(routeLayerGroup)
        // Точки остановок
        stops.forEach(stop => {
          L.circleMarker([stop.lat, stop.lon], { radius: 5, color: colors[colorIndex % colors.length] })
            .addTo(routeLayerGroup)
            .bindTooltip(String(stop.order), { permanent: true, direction: 'center',});
        });

        colorIndex++;
      });

      map.fitBounds(routeLayerGroup.getBounds(), {
      padding: [40, 40]
      });
    };

    function onMapClick(e) {
    const data = {
      message: "Вы выбрали точку с координатами:",
      coordinates: {
        lat: e.latlng.lat,
        lon: e.latlng.lng
      }
    };
    renderJson(data);
   }

    function renderJson(data) {json_cont.textContent = JSON.stringify(data, null, 2);};

    map.on('click', onMapClick);

    const search_route = document.getElementById("searchBtn");
    search_route.addEventListener("click", searchRoute);

    const view_route = document.getElementById("view_route_Btn");
    view_route.addEventListener("click", viewRoute);

});