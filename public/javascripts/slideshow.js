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
      self.getCaptions().removeClass('current').css({opacity: 0.7});
      var index = self.getImages().index(next);
      self.getCaptions().eq(index).addClass('current').css({opacity: 1.0});
    }

    this.gallery = function() {
      self.moveTo(self.getNext());
    }

    this.getImages = function(){
      return $this.children('li').not('.caption');
    };

    this.getCaptions = function(){
      return $('.slideshow-caption-container li', $this);
    };

    //Delete, trigger by caption
    this.destroy = function(){
      var index = self.getCaptions().index($(this));
      self.getImages().eq(index).remove();
      $(this).remove();
      self.getCaptions().each(function(){
        $(this).width($this.width()/self.getImages().size() - 2);
      });
    }

    this.refresh_caption_width = function(){
      self.getCaptions().each(function(){
        //reduce 2px for li left and right padding
        $(this).width($this.width()/self.getImages().size() - 2);
      });
    }

    //Add
    this.refresh_caption = function(){
      self.getImages().each( self.generate_caption );
      self.refresh_caption_width();
    }

    //Move, will trigger by sortable plugin
    this.caption_moved = function(){
      var index = self.getCaptions().index($(this));
      var origin = $(".slideshow [rel_id='" + $(this).attr('id') + "']");
      if(index > self.getImages().index(origin))
        self.getImages().eq(index).after(origin);
      else
        self.getImages().eq(index).before(origin);
    }

    //generate_caption
    this.generate_caption = function(){
      if(!$(this).attr('id')) return;
      var caption = $("<li class='editable'/>");
      //editable attr
      caption.attr({'edit_width': $(this).attr('edit_width'), 'edit_height': $(this).attr('edit_height'), 'id': $(this).attr('id')});
      caption.bind('slideshow.destroy', self.destroy);
      $(this).removeAttr('edit_width').removeAttr('edit_height').attr('rel_id', $(this).attr('id')).removeAttr('id');
      if($(this).prev()[0])
        $('#' + $(this).prev().attr('rel_id')).after(caption);
      else
        $('.slideshow-caption-container', $this).prepend(caption);
      var text = $('<a/>').html($('img', $(this)).attr('alt'));
      text.attr('href', $(this).find('a').attr('href'));
      caption.append(text);

      caption.bind('sortable.update', self.caption_moved);

      //point to current
      self.getCaptions().mouseover(function(){
        if(!$(this).hasClass('current')){
          var index = self.getCaptions().index($(this));
          var next = self.getImages().eq(index);
          self.moveTo(next);
        }
      });
    }

    this.slideshow = function(){
      //Set the opacity of all images to 0
      $('li', $this).css({opacity: 0.0});

      //Get the first image and display it (set it to full opacity)
      $('li:first', $this).css({opacity: 1.0});

      //append a LI item to the UL list for displaying caption
      $this.append('<li class="slideshow-caption caption"><ul class="slideshow-caption-container sortable" sort_url="/focuses/sort"></ul></li>');

      //Display the caption
      $('.slideshow-caption', $this).css({opacity: 0.7, top:355});

      //Get the caption of the first image from REL attribute and display it
      self.refresh_caption();

      //Call the gallery function to run the slideshow	
      this.gallery();
      var timer = setInterval(function(){ self.gallery() }, settings.speed);
      //修正:鼠标悬停频繁时会产生多个timer的问题，导致标题切换混乱
      var timer_cleared = false;

      //pause the slideshow on mouse over
      $this.hover(function () {
        if(!timer_cleared){
          clearInterval(timer);
          timer_cleared = true;
        }
      }, function () {
        if(timer_cleared){
          timer = setInterval(function(){ self.gallery() }, settings.speed);
          timer_cleared = false;
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
