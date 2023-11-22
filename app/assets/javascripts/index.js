function prevImg() {
    console.log("prev")
    const slides = document.querySelectorAll(".carousel-slide")
    const slidesContainer = document.querySelector(".carousel-slides")
    console.log(slides)
    offset = -1
    let newIndex = 0;
    let activeSlide;
    let width;
    slides.forEach(
        function(node, index) {
            if (node.classList.contains("active")) {
                newIndex = index + offset;
                activeSlide = node;
                width = activeSlide.clientWidth;
            }
        }
    );

    if (newIndex < 0) newIndex = slides.length - 1
    if (newIndex >= slides.length) newIndex = 0

    slidesContainer.style.transform = 'translateX(' + -newIndex*400 + 'px)'
    console.log(width)

    activeSlide.classList.remove("active")
    slides[newIndex].classList.add("active")
}

function nextImg() {
    console.log("next")
    const slides = document.querySelectorAll(".carousel-slide")
    const slidesContainer = document.querySelector(".carousel-slides")
    console.log(slides)
    offset = 1
    let activeSlide;
    let width;
    slides.forEach(
        function(node, index) {
            if (node.classList.contains("active")) {
                newIndex = index + offset;
                activeSlide = node;
                width = activeSlide.clientWidth;
            }
        }
    );

    if (newIndex < 0) newIndex = slides.length - 1
    if (newIndex >= slides.length) newIndex = 0

    slidesContainer.style.transform = 'translateX(' + -newIndex*400 + 'px)'
    console.log(width)

    activeSlide.classList.remove("active")
    slides[newIndex].classList.add("active")
}