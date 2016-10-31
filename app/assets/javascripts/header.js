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

  $("#user-storages").on("click", function() {
    var letters = $("#storage-letters");
    var display_info = letters.css("display");
    if (display_info == "none") {
      letters.css("display", "block");
    } else {
      letters.css("display", "none");
    }
  });
});
