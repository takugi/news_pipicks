$(function() {
  $(document).ready(function() {
    $("#logo").fadeIn(0.1, function() {
      $("#logo").animate({width: "40%", height: "50%", top: "25%", left: "30%", opacity: "0"}, 700, function() {
        $("#logo").fadeOut(0.1);
      });
    });
    $("#flash").fadeIn(1000, function() {
      setTimeout(function() {
        $("#flash").fadeOut(2000);
      }, 1000);
    });
  });
});
