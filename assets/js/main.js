import "htmx.org"

import "hyperscript.org"

import Alpine from "alpinejs"

window.Alpine = Alpine

Alpine.start()

document.documentElement.className = document.documentElement.className.replace(
  "no-js",
  "js"
)
document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('.content [href^="#"]').forEach((link) => {
    link.addEventListener("click", (link) => {
      link.preventDefault(),
        document
          .getElementById(link.getAttribute("href").substring(1))
          .scrollIntoView({ behavior: "smooth" })
    })
  }),
    document.querySelectorAll('.content [href^="http"]').forEach((link) => {
      link.setAttribute("target", "_blank")
    })
})
document.addEventListener("DOMContentLoaded", function () {
  if (
    (document.getElementById("toggleTheme").addEventListener("click", () => {
      if (document.documentElement.getAttribute("data-mode") === "dark")
        document.documentElement.setAttribute("data-mode", "light"),
          (localStorage.theme = "light"),
          (toggleTheme.innerHTML = "🌚")
      else
        document.documentElement.setAttribute("data-mode", "dark"),
          (localStorage.theme = "dark"),
          (toggleTheme.innerHTML = "🌝")
    }),
    !("theme" in localStorage) ||
      document.documentElement.getAttribute("data-mode", "dark") ||
      window.matchMedia("(prefers-color-scheme: auto)").matches)
  )
    localStorage.theme = "auto"
  if (
    localStorage.theme === "auto" ||
    (!("theme" in localStorage) &&
      window.matchMedia("(prefers-color-scheme: auto)").matches)
  )
    document.documentElement.setAttribute("data-mode", "auto"),
      (localStorage.theme = "auto"),
      (document.getElementById("toggleTheme").innerHTML = "🌓")
  if (
    localStorage.theme === "dark" ||
    (!("theme" in localStorage) &&
      window.matchMedia("(prefers-color-scheme: dark)").matches)
  )
    document.documentElement.setAttribute("data-mode", "dark"),
      (localStorage.theme = "dark"),
      (document.getElementById("toggleTheme").innerHTML = "🌝")
  if (
    localStorage.theme === "light" ||
    (!("theme" in localStorage) &&
      window.matchMedia("(prefers-color-scheme: light)").matches)
  )
    document.documentElement.setAttribute("data-mode", "light"),
      (localStorage.theme = "light"),
      (document.getElementById("toggleTheme").innerHTML = "🌚")
})
