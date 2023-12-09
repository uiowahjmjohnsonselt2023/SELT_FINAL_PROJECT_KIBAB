let slideIndex = 0;
window.onload = function showSlides() {
    const slides = document.querySelectorAll('.carousel-slide')
    let dots = document.querySelectorAll(".dot")

    slides.forEach((slide) => {
        slide.style.display = "none";
    })
    slideIndex = slideIndex + 1;
    console.log(slideIndex);

    if (slideIndex > slides.length) {slideIndex = 1}

    dots.forEach((dot) => {
        dot.className.replace(" active","")
    })

    slides.item((slideIndex-1)).style.display = "block";
    dots.item((slideIndex-1)).className += " active";
    setTimeout(showSlides, 2000);
}