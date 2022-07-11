/**
 * header sticky
 */

const header = document.querySelector("[data-header]");
window.addEventListener("scroll", function () {
    window.scrollY >= 10 ? header.classList.add("active") : header.classList.remove("active");
});


/**
 * go top
 */
const goTopBtn = document.querySelector("[data-go-top]");

window.addEventListener("scroll", function () {
    window.scrollY >= 500 ? goTopBtn.classList.add("active") : goTopBtn.classList.remove("active");
});


/**
 * login button
 */
const loginBtn = document.querySelector("#loginBtn");
loginBtn.addEventListener("click", function () {
    location.href = '/member?parma=login';
});