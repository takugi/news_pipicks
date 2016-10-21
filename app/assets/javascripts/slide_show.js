$(function() {
  var flame1 = $(".container__topics__flame__main-flame");
  var flame2 = $(".container__topics__flame__sub-flame__first");
  var flame3 = $(".container__topics__flame__sub-flame__second");
  var image1 = $(".container__topics__flame__main-flame__link__image");
  var image2 = $(".container__topics__flame__sub-flame__first__image");
  var image3 = $(".container__topics__flame__sub-flame__second__image");

  flame1.on("mouseover", function()  {
    image1.css("opacity", "0.4");
  });

  flame1.on("mouseout", function()  {
    image1.css("opacity", "0.65");
  });

  flame2.on("mouseover", function()  {
    image2.css("opacity", "0.4");
  });

  flame2.on("mouseout", function()  {
    image2.css("opacity", "0.65");
  });

  flame3.on("mouseover", function()  {
    image3.css("opacity", "0.4");
  });

  flame3.on("mouseout", function()  {
    image3.css("opacity", "0.65");
  });
});

$(document).ready(function(){
  var huga = $('.bxslider').bxSlider({
    auto: true,
    onSlideAfter: function() {
      huga.startAuto();
    },
    pause: 6000,
    speed: 2000,
    mode: "fade",
    pager: true,
    prevText: "<",
    nextText: ">",
  });
});
