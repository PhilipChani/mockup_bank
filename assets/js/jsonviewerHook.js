// assets/js/hooks/json_viewer.js
import JsonViewer from '../node_modules/json-viewer-js'; // Adjust the path to where JsonViewer is located

const JsonViewerHook = {
  mounted() {
    const testJson = this.el.dataset.json;

    new JsonViewer({
      container: this.el,  // Attach it to the element the hook is bound to
      data: testJson,
      theme: 'dark',
      expand: true,
    });
  },

  updated() {
    const testJson = this.el.dataset.json;

    new JsonViewer({
      container: this.el,  // Attach it to the element the hook is bound to
      data: testJson,
      theme: 'dark',
      expand: true,
    });
  },
  renderJsonViewer() {
    const jsonData = this.el.dataset.json; // Fetch the updated JSON data

    // Clear the container if necessary to prevent duplicating the viewer
    this.el.innerHTML = '';

    // Render the JsonViewer
    new JsonViewer({
      container: this.el,  // Attach it to the element the hook is bound to
      data: testJson,
      theme: 'dark',
      expand: true,
    });
  }
};

export default JsonViewerHook;
