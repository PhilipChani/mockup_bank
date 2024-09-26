// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
import JsonViewerHook  from "./jsonviewerHook"





(async () => {
  const modules = await Promise.all([
    import('../vendor/dist/js/vendors/dom.js'),
    import('../vendor/dist/js/vendors/tailwind-merge.js'),
    import('../vendor/dist/js/vendors/lucide.js'),
    import('../vendor/dist/js/vendors/dayjs.js'),
    import('../vendor/dist/js/vendors/litepicker.js'),
    import('../vendor/dist/js/vendors/tippy.js'),
    import('../vendor/dist/js/vendors/tab.js'),
    import('../vendor/dist/js/vendors/popper.js'),
    import('../vendor/dist/js/vendors/simplebar.js'),
    import('../vendor/dist/js/vendors/chartjs.js'),
    import('../vendor/dist/js/vendors/transition.js'),
    import('../vendor/dist/js/vendors/modal.js'),
    import('../vendor/dist/js/vendors/dropdown.js'),
    import('../vendor/dist/js/components/base/theme-color.js'),
    import('../vendor/dist/js/components/base/lucide.js'),
    import('../vendor/dist/js/components/base/litepicker.js'),
    import('../vendor/dist/js/components/base/tippy.js'),
    import('../vendor/dist/js/utils/colors.js'),
    import('../vendor/dist/js/utils/helper.js'),
    import('../vendor/dist/js/components/report-line-chart-1.js'),
    import('../vendor/dist/js/components/report-bar-chart-1.js'),
    import('../vendor/dist/js/components/report-line-chart-2.js'),
    import('../vendor/dist/js/components/report-donut-chart-1.js'),
    import('../vendor/dist/js/themes/waveform.js'),
    import('../vendor/dist/js/components/quick-search.js')
  ]);

  modules.forEach(module => Object.assign(window, module));
})();

// Add this function
async function loadModules() {
  const modules = await Promise.all([
    import('../vendor/dist/js/vendors/dom.js'),
    import('../vendor/dist/js/vendors/tailwind-merge.js'),
    import('../vendor/dist/js/vendors/lucide.js'),
    import('../vendor/dist/js/vendors/dayjs.js'),
    import('../vendor/dist/js/vendors/litepicker.js'),
    import('../vendor/dist/js/vendors/tippy.js'),
    import('../vendor/dist/js/vendors/tab.js'),
    import('../vendor/dist/js/vendors/popper.js'),
    import('../vendor/dist/js/vendors/simplebar.js'),
    import('../vendor/dist/js/vendors/chartjs.js'),
    import('../vendor/dist/js/vendors/transition.js'),
    import('../vendor/dist/js/vendors/modal.js'),
    import('../vendor/dist/js/vendors/dropdown.js'),
    import('../vendor/dist/js/components/base/theme-color.js'),
    import('../vendor/dist/js/components/base/lucide.js'),
    import('../vendor/dist/js/components/base/litepicker.js'),
    import('../vendor/dist/js/components/base/tippy.js'),
    import('../vendor/dist/js/utils/colors.js'),
    import('../vendor/dist/js/utils/helper.js'),
    import('../vendor/dist/js/components/report-line-chart-1.js'),
    import('../vendor/dist/js/components/report-bar-chart-1.js'),
    import('../vendor/dist/js/components/report-line-chart-2.js'),
    import('../vendor/dist/js/components/report-donut-chart-1.js'),
    import('../vendor/dist/js/themes/waveform.js'),
    import('../vendor/dist/js/components/quick-search.js')
  ]);

  modules.forEach(module => Object.assign(window, module));
}

let Hooks = {
  JsonViewerHook: JsonViewerHook,
  InitializeModules: {
    mounted() {
      loadModules();
    }
  }
};


let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: Hooks
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

