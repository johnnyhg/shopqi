$(document).ready(function() {		
    //Execute the slideShow, set 3 seconds for each images
    slideShow(3000);
});

function slideShow(speed) {
  //Set the opacity of all images to 0
  $('ul.slideshow li').css({opacity: 0.0}).addClass('slideshow_image');

  //Get the first image and display it (set it to full opacity)
  $('ul.slideshow li:first').css({opacity: 1.0});

  //append a LI item to the UL list for displaying caption
  $('ul.slideshow').append('<li id="slideshow-caption" class="caption"><ul class="slideshow-caption-container"></ul></li>');

  //Display the caption
  $('#slideshow-caption').css({opacity: 0.7, top:355});

  //Get the caption of the first image from REL attribute and display it
  var slideshow_image_size = $('ul.slideshow li.slideshow_image').size();
  $('ul.slideshow li.slideshow_image').each(function(){
    var caption = $('<li/>');
    //reduce 2px for li left and right padding
    caption.appendTo('.slideshow-caption-container').width($('.slideshow').width()/slideshow_image_size - 2);
    var text = $('<a/>').html($('img', this).attr('title'));
    text.attr('href', $(this).find('a').attr('href'));
    caption.append(text);
  });

  //Call the gallery function to run the slideshow	
  gallery();
  var timer = setInterval('gallery()',speed);

  //pause the slideshow on mouse over
  $('ul.slideshow').hover(function () {
    clearInterval(timer);	
  }, function () {
    timer = setInterval('gallery()',speed);			
  });

  //point to current
  $('ul.slideshow .slideshow-caption-container li').mouseover(function(){
    if(!$(this).hasClass('current')){
      var index = $('ul.slideshow .slideshow-caption-container li').index($(this));
      var next = $('ul.slideshow > li').eq(index);
      moveTo(next);
    }
  });
}

function gallery() {
  moveTo(getNext());
}

//if no IMGs have the show class, grab the first image
function getCurrent(){
  return ($('ul.slideshow li.show') ?  $('ul.slideshow li.show') : $('#ul.slideshow li:first'));
}

//Get next image, if it reached the end of the slideshow, rotate it back to the first image
function getNext(){
  var current = getCurrent();
  return ((current.next().length) ? ((current.next().attr('id') == 'slideshow-caption')? $('ul.slideshow li:first') :current.next()) : $('ul.slideshow li:first'));
}

function moveTo(next){
  var current = getCurrent();

  //Set the fade in effect for the next image, show class has higher z-index
  next.css({opacity: 0.0}).addClass('show').animate({opacity: 1.0}, 1000);

  //Hide the current image
  current.animate({opacity: 0.0}, 1000).removeClass('show');

  //Display the content
  $('.slideshow-caption-container li').removeClass('current').css({opacity: 0.7});
  var index = $('ul.slideshow > li').index(next);
  $('.slideshow-caption-container li').eq(index).addClass('current').css({opacity: 1.0});
}
