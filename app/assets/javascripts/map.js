function initMap() {
    const coords = document.getElementById("product_location");

    const product = {
        lat: parseFloat(coords.getAttribute("data-latitude")),
        lng: parseFloat(coords.getAttribute("data-longitude"))
    };

    // (document.getElementById("product_map")

    const map = new google.maps.Map(document.getElementById("product_map"), {
        zoom: 10,
        center: product,
    });
}

window.initMap = initMap;