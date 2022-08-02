let Uploaders = {}

Uploaders.S3 = function (entries, onViewError) {
    entries.forEach(entry => {
      let xhr = new XMLHttpRequest()
      onViewError(() => xhr.abort())
      xhr.onload = () => xhr.status === 204 ? entry.progress(100) : entry.error()
      xhr.onerror = () => entry.error()
      xhr.upload.addEventListener("progress", event => {
        if (event.lengthComputable) {
          let percent = Math.round((event.loaded / event.total) * 100)
          entry.progress(percent)
        }
      })
  
      xhr.open("PUT", entry.meta.url, true)
      xhr.send(entry.file)
    })
  }

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
    uploaders: Uploaders,
    params: { _csrf_token: csrfToken }
})

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

let dropdown = document.getElementById("dropdown")
let dropdownButton = document.getElementById("dropdown-button")

dropdownButton.addEventListener("mouseenter", () => {
  dropdown.classList.remove("invisible")
})

dropdown.addEventListener("mouseleave", () => {
  dropdown.classList.add("invisible")
})
