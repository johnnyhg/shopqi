$(document).ready(function() {		
    //Execute the slideShow, set 4 seconds for each images
    slideShow(4000);
});

function slideShow(speed) {
  //Set the opacity of all images to 0
  $('ul.slideshow li').css({opacity: 0.0}).addClass('slideshow_image');

  //Get the first image and display it (set it to full opacity)
  $('ul.slideshow li:first').css({opacity: 1.0});

  //append a LI item to the UL list for displaying caption
  $('ul.slideshow').append('<li id="slideshow-caption" class="caption"><ul class="slideshow-caption-container"></ul></li>');

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

  //Display the caption
  $('#slideshow-caption').css({opacity: 0.7, top:355});

  //Call the gallery function to run the slideshow	
  var timer = setInterval('gallery()',speed);

  //pause the slideshow on mouse over
  $('ul.slideshow').hover(function () {
    clearInterval(timer);	
  }, function () {
    timer = setInterval('gallery()',speed);			
  });

}

function gallery() {
  //if no IMGs have the show class, grab the first image
  var current = ($('ul.slideshow li.show')?  $('ul.slideshow li.show') : $('#ul.slideshow li:first'));

  //Get next image, if it reached the end of the slideshow, rotate it back to the first image
  var next = ((current.next().length) ? ((current.next().attr('id') == 'slideshow-caption')? $('ul.slideshow li:first') :current.next()) : $('ul.slideshow li:first'));

  //Get next image caption
  var title = next.find('img').attr('title');	

  //Set the fade in effect for the next image, show class has higher z-index
  next.css({opacity: 0.0}).addClass('show').animate({opacity: 1.0}, 1000);

  //Display the content
  $('.slideshow-caption-container li').removeClass('current').css({opacity: 0.7});
  var index = $('ul.slideshow > li').index(next);
  $('.slideshow-caption-container li:eq(' + index + ')').addClass('current').css({opacity: 1.0});

  //Hide the current image
  current.animate({opacity: 0.0}, 1000).removeClass('show');

}
