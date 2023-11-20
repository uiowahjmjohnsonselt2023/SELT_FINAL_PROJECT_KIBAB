console.log("hello")
buttons = document.querySelectorAll("button.carousel-button")
console.log(document.title)

function prevImg() {
    console.log("prev")
    const slides = document.querySelectorAll("carousel-slides")
    offset = -1
    const activeSlide = document.querySelector("carousel-slides active")
    let newIndex = [...slides.children].indexOf(activeSlide) + offset

    if (newIndex < 0) newIndex = slides.children.length - 1
    if (newIndex >= slides.children.length) newIndex = 0

    slides.children[newIndex].classList.add("active")
    activeSlide.classList.remove("active")
}

function nextImg() {
    console.log("next")
    const slides = document.querySelectorAll("carousel-slides")
    offset = 1
    const activeSlide = document.querySelector("carousel-slides active")
    console.log(slides.children)
    let newIndex = [...slides.children].indexOf(activeSlide) + offset

    if (newIndex < 0) newIndex = slides.children.length - 1
    if (newIndex >= slides.children.length) newIndex = 0

    slides.children[newIndex].classList.add("active")
    activeSlide.classList.remove("active")
}

// buttons.forEach(button => {
//     button.addEventListener("click", () => {
//         console.log("entered")
//         offset =  0
//         if (button.classList.contains("next")) {
//             offset = 1
//         }
//         else  {
//             offset = -1
//         }
//         const slides = button.closest("carousel").querySelector("carousel-slides")
//
//         const activeSlide = slides.querySelector("carousel-slide active")
//         let newIndex = [...slides.children].indexOf(activeSlide) + offset
//
//         if (newIndex < 0) newIndex = slides.children.length - 1
//         if (newIndex >= slides.children.length) newIndex = 0
//
//         slides.children[newIndex].classList.add("active")
//         activeSlide.classList.remove("active")
//     })
// })