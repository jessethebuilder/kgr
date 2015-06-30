function normalizeArticle(){
  $('.article_content').css('min-height', $('.article_content').find('.article_image').height());
}


$(document).ready(function(){
  normalizeArticle();
});


