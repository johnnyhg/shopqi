/*!
 * jquery.accordion. The jQuery accordion plugin
 *
 * Copyright (c) 2010 saberma
 * http://www.shopqi.com
 *
 * Licensed under MIT
 * http://www.opensource.org/licenses/mit-license.php
 *
 * Launch  : Sep 2010
 * Version : 1.0.0
 * Released: Tue 14th Sep, 2010 - 00:00
 */
(function($) {
  var Accordion = function(element, options){
    var self = this,
      $this = $(element),
      defaults = { },
      settings = $.extend(defaults, options || {});

    this.accordion = function(){
      $this.find('dd:last').show();
      $this.find('dt:last').addClass('showimg');
      $this.find('dt').mouseover(function(){
        if(!$(this).hasClass('showimg')){
          $this.find('.showimg').next().hide();
          $this.find('.showimg').removeClass('showimg');
          $(this).addClass('showimg');
          $(this).next().show();
        }
      });
    }

    this.accordion();
  }

  $.fn.extend({
    accordion: function(options){
      return this.each(function(){
        if($(this).data('accordion')) return;

        var accordion = new Accordion(this, options);
        $(this).data('accordion', accordion);
      });
    }
  });
})(jQuery);
