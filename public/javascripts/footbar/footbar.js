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
 *
 * http://www.sohtanaka.com/web-design/facebook-style-footer-admin-panel-part-1/
 * http://www.sohtanaka.com/web-design/facebook-style-footer-admin-panel-part-2/
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
      if(button.hasClass('active')){
        $this.removeData('actived_subpanel');
        button.removeClass('active');
        subpanel.hide();
      //show it
      }else{
        var last_button = $this.data('actived_subpanel');
        if(last_button)
          last_button.removeClass('active').next('.subpanel').hide();
        $this.data('actived_subpanel', button);
        button.addClass('active');
        subpanel.show();
        //its remote content?
        var remote_url = button.attr('data-url');
        if(remote_url){
          subpanel.html('');
          subpanel.addClass('loading');
          $.get(remote_url, function(data){
            subpanel.removeClass('loading');
            subpanel.html(data);
          });
        }
      }
    };

    this.render = function(){
      $this.delegate('ul > li > a', 'click', this.toggle);
      $this.delegate('.subpanel > h3 > span', 'click', this.toggle);
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
