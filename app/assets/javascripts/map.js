function initMap() {
    const coords = document.getElementById("product_location");

    const product = {
        lat: parseFloat(coords.getAttribute("data-latitude")),
        lng: parseFloat(coords.getAttribute("data-longitude"))
    };

    const product_name = coords.getAttribute("data-name")
    // (document.getElementById("product_map")

    const map = new google.maps.Map(document.getElementById("product_map"), {
        zoom: 15,
        center: product,
    });

     new google.maps.Marker({
        position: product,
        map,
        title: product_name,
    });
}

window.initMap = initMap;