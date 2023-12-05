function initMap() {
    const coords = document.getElementById("product_location");
    console.log(coords.getAttribute("data-latitude"))
    console.log(coords.getAttribute("data-longitude"))

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