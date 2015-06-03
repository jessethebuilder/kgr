function raiseAndLowerElement(selector){
  $(selector).hover(function(){
    $(this).animate({
      top: "-10px"
    }, 500, function(){} )
  }, function(){
    $(this).animate({
      top: "0px"
    }, 250, function(){})
  });
}
