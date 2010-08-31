/*!
 * jquery.slideshow. The jQuery slideshow plugin
 *
 * Copyright (c) 2010 saberma
 * http://www.shopqi.com
 *
 * Licensed under MIT
 * http://www.opensource.org/licenses/mit-license.php
 *
 * Launch  : August 2010
 * Version : 1.0.0
 * Released: Monday 30th August, 2010 - 00:00
 */
(function($) {
  var Slideshow = function(element, options){
    var self = this,
      $this = $(element),
      defaults = { speed: 3000 },
      settings = $.extend(defaults, options || {});

    //if no IMGs have the show class, grab the first image
    this.getCurrent = function(){
      return ($('li.show', $this) ? $('li.show', $this) : $('li:first', $this));
    }

    //Get next image, if it reached the end of the slideshow, rotate it back to the first image
    this.getNext = function(){
      var current = this.getCurrent();
      return ((current.next().length) ? ((current.next().hasClass('slideshow-caption')) ? $('li:first', $this) :current.next()) : $('li:first', $this));
    }

    this.moveTo = function(next){
      var current = this.getCurrent();

      //Set the fade in effect for the next image, show class has higher z-index
      next.css({opacity: 0.0}).addClass('show').animate({opacity: 1.0}, 1000);

      //Hide the current image
      current.animate({opacity: 0.0}, 1000).removeClass('show');

      //Display the content
      $('.slideshow-caption-container li', $this).removeClass('current').css({opacity: 0.7});
      var index = $('> li', $this).index(next);
      $('.slideshow-caption-container li', $this).eq(index).addClass('current').css({opacity: 1.0});
    }

    this.gallery = function() {
      self.moveTo(self.getNext());
    }

    this.slideshow = function(){
      //Set the opacity of all images to 0
      $('li', $this).css({opacity: 0.0}).addClass('slideshow_image');

      //Get the first image and display it (set it to full opacity)
      $('li:first', $this).css({opacity: 1.0});

      //append a LI item to the UL list for displaying caption
      $this.append('<li class="slideshow-caption caption"><ul class="slideshow-caption-container"></ul></li>');

      //Display the caption
      $('.slideshow-caption', $this).css({opacity: 0.7, top:355});

      //Get the caption of the first image from REL attribute and display it
      var slideshow_image_size = $('li.slideshow_image', $this).size();
      $('li.slideshow_image', $this).each(function(){
        var caption = $('<li/>');
        //reduce 2px for li left and right padding
        $('.slideshow-caption-container', $this).append(caption);
        caption.width($this.width()/slideshow_image_size - 2);
        var text = $('<a/>').html($('img', this).attr('alt'));
        text.attr('href', $(this).find('a').attr('href'));
        caption.append(text);
      });

      //Call the gallery function to run the slideshow	
      this.gallery();
      var timer = setInterval(function(){ self.gallery() }, settings.speed);

      //pause the slideshow on mouse over
      $this.hover(function () {
        clearInterval(timer);	
      }, function () {
        timer = setInterval(function(){ self.gallery() }, settings.speed);
      });

      //point to current
      $('.slideshow-caption-container li', $this).mouseover(function(){
        if(!$(this).hasClass('current')){
          var index = $('.slideshow-caption-container li', $this).index($(this));
          var next = $('> li', $this).eq(index);
          self.moveTo(next);
        }
      });
    }

    this.slideshow();
  }

  $.fn.extend({
    slideshow: function(options){
      return this.each(function(){
        if($(this).data('slideshow')) return;

        var slideshow = new Slideshow(this, options);
        $(this).data('slideshow', slideshow);
      });
    }
  });
})(jQuery);
