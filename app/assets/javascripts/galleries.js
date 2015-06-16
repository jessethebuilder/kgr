function galleryNameHoverHighlight(){
  $('.gallery_image_container').hover(function(){
    $(this).find('.gallery_image_name').addClass('bright_background');
  }, function(){
    $(this).find('.gallery_image_name').removeClass('bright_background');
  });
}

function galleryNameWidthNormalize(){
  $('.gallery_image_container').each(function(i){
    var w = $(this).find('.gallery_image').width();
    $(this).width(w);
  })
}