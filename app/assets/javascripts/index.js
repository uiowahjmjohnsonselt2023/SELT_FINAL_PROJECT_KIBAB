console.log("hello")
buttons = document.querySelectorAll("button.carousel-button")
console.log(document.title)

function prevImg() {
    console.log("prev")
    const slides = document.querySelectorAll(".carousel-slide")
    console.log(slides)
    offset = -1
    let newIndex = 0;
    let activeSlide;
    slides.forEach(
        function(node, index) {
            if (node.classList.contains("active")) {
                newIndex = index + offset;
                activeSlide = node;
            }
        }
    );

    if (newIndex < 0) newIndex = slides.length - 1
    if (newIndex >= slides.length) newIndex = 0

    activeSlide.classList.remove("active")
    slides[newIndex].classList.add("active")
}

function nextImg() {
    console.log("next")
    const slides = document.querySelectorAll(".carousel-slide")
    console.log(slides)
    offset = 1
    let activeSlide;
    slides.forEach(
        function(node, index) {
            if (node.classList.contains("active")) {
                newIndex = index + offset;
                activeSlide = node;
            }
        }
    );


    if (newIndex < 0) newIndex = slides.length - 1
    if (newIndex >= slides.length) newIndex = 0

    activeSlide.classList.remove("active")
    slides[newIndex].classList.add("active")
}