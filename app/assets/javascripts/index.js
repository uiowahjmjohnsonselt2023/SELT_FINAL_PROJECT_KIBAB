let slideIndex = 0;
(function showSlides() {
    let slides = document.querySelectorAll(".carousel-slide")
    console.log(slides.length)
    let dots = document.querySelectorAll(".dot")

    slides.forEach((slide) => {
        console.log(slide)
        slide.style.display = "none";
    })
    slideIndex = slideIndex + 1;

    if (slideIndex > slides.length) {slideIndex = 1}

    dots.forEach((dot) => {
        dot.className.replace(".active","")
    })

    slides.item((slideIndex-1)).style.display = "block";
    dots.item((slideIndex-1)).className += " active";
    setTimeout(showSlides, 2000);
})();