(() => {
  // src/js/components/quick-search.js
  var el = document.querySelector("#quick-search");
  var modal = tailwind.Modal.getOrCreateInstance(el);
  document.onkeydown = function(evt) {
    if ((evt.ctrlKey || evt.metaKey) && evt.key === "k") {
      modal.show();
    }
  };
  $(el).on("shown.tw.modal", function() {
    $(el).find("input").first()[0].focus();
  });
})();
