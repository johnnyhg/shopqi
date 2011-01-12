/*!
 * jquery.footbar. The jQuery fixed position bar plugin
 *
 * Copyright (c) 2010 saberma
 * http://www.shopqi.com
 *
 * Licensed under MIT
 * http://www.opensource.org/licenses/mit-license.php
 *
 * Launch  : January 2010
 * Version : 1.0.0
 * Released: Tuesday 11th January, 2010 - 00:00
 */
(function($) {
  var Footbar = function(element, options){
    var self = this,
      $this = $(element),
      defaults = {},
      settings = $.extend(defaults, options || {});

    this.toggle = function(){
      var li = $(this).closest('li');
      var subpanel = $('.subpanel', li);
      var button = $('> a', li);
      if(!subpanel[0]) return;
      if(button.hasClass('active')){
        $this.removeData('actived_subpanel');
        button.removeClass('active');
        subpanel.hide();
      }else{
        var last_button = $this.data('actived_subpanel');
        if(last_button)
          last_button.removeClass('active').next('.subpanel').hide();
        $this.data('actived_subpanel', button);
        button.addClass('active');
        subpanel.show();
      }
    };

    this.render = function(){
      $('.subpanel > h3 > span', $this).live('click', this.toggle);
      $('ul > li > a', $this).live('click', this.toggle);
    }

    this.render();
  }

  $.fn.extend({
    footbar: function(options){
      return this.each(function(){
        if($(this).data('footbar')) return;
        $(this).data('footbar', new Footbar(this, options));
      });
    }
  });
})(jQuery);
