$(function() {
  $("#user-header-image").on("click", function() {
    var user_info = $("#user-menu-container");
    var display_info = user_info.css("display");
    if (display_info == "none") {
      user_info.css("display", "block");
    } else {
      user_info.css("display", "none");
    }
  });
});
