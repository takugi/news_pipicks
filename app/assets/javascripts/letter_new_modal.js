$(function() {
  var openTrigger = $("#letter-new");
  var modal = $("#letter-new-modal");
  var closeTrigger = $(".modal__back");

  openTrigger.on("click", function() {
    modal.css("visibility", "visible");
  });

  closeTrigger.on("click", function() {
    modal.css("visibility", "hidden");
  });
});
