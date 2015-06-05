function raiseAndLowerElement(selector){
  $(selector).hover(function(){
    $(this).stop().animate({
      top: "-10px"
    }, 500, function(){} )
  }, function(){
    $(this).animate({
      top: "0px"
    }, 100, function(){}).animate({
      top: "-3px"
    }, 75, function(){}).animate({
      top: "0px"
    }, 50, function(){});
  });
}
