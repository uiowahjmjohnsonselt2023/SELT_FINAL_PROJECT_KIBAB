function prevImg() {
    console.log("prev")
    const slides = document.querySelectorAll(".carousel-slide")
    const slidesContainer = document.querySelector(".carousel-slides")
    console.log(slides)
    offset = -1
    let newIndex = 0;
    let activeSlide;
    size = allImageSizes();
    slides.forEach(
        function(node, index) {
            if (node.classList.contains("active")) {
                newIndex = index + offset;
                activeSlide = node;
            }
        }
    );

    if (newIndex < 0) newIndex = slides.length - 1
    if (newIndex >= slides.length-1) newIndex = 0

    slidesContainer.style.transform = 'translateX(' + 0.9*(-newIndex*(size / slides.length) ) + 'px)'
    console.log("translate")

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
    size = allImageSizes();
    slides.forEach(
        function(node, index) {
            if (node.classList.contains("active")) {
                newIndex = index + offset;
                activeSlide = node;
            }
        }
    );

    if (newIndex < 0) newIndex = slides.length - 1
    if (newIndex >= slides.length-1) newIndex = 0

    slidesContainer.style.transform = 'translateX(' + 0.9*(-newIndex*(size / slides.length) )+ 'px)'
    console.log("translate")

    activeSlide.classList.remove("active")
    slides[newIndex].classList.add("active")
}

function allImageSizes() {
    const slides = document.querySelectorAll(".carousel-slide");
    size = 0;
    slides.forEach(
        function(node) {
            size = size + node.clientWidth;
        }
    );
    return size;
}

