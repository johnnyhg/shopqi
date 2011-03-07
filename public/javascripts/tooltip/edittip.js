/*!
 * jquery.editTip. The jQuery edit link plugin
 *
 * Copyright (c) 2010 saberma
 * http://www.shopqi.com
 *
 * Licensed under MIT
 * http://www.opensource.org/licenses/mit-license.php
 *
 * Launch  : Feb 2011
 * Version : 1.0.0
 * Released: Fri 18th Feb, 2011 - 00:00
 *
 * Features:
 * 1. support a lot elements shows the tooltip(use jquery delegate);
 * 2. once the tooltip show, do not hide it until we click the document;
 */
jQuery(function ($) {
  var $editTip = $('<div id="edittip"><div><a href="#">编辑</a></div></div>').hide().appendTo('body');
  $('#loading-indicator').ajaxStart(function(){$(this).show()}).ajaxStop(function(){$(this).hide()});
  $('a', $editTip).mousedown(function(){
    $("#tooltip").load($editTip.data('url'), function(){ 
      $('#tooltip').modal({minWidth: 300, minHeight: 180});
    });
  });
  $(document).mousedown(function(){ $editTip.hide().removeData('trigger'); });

  var tip = {
    position: function(event) {
      $editTip.css({
        top: event.pageY - $editTip.outerHeight()/2 + 15,
        left: event.pageX - $editTip.outerWidth()/2
      });
    }
  };

  $('body').delegate('.editable > a', 'mouseenter', function(event) {
    var link = this,
        $link = $(this);
    var trigger = $editTip.data('trigger');
    if(!trigger || (trigger && trigger!=this)) {
      $editTip.data('trigger', this);
      tip.position(event);
      $editTip.fadeOut(0).fadeIn(200);
      var obj = $link.parent();
      var url = pluralize_name(obj.attr('id')) + '/' + id(obj.attr('id')) + '/edit';
      $editTip.data('url', url);
    }
  });

  $('body').delegate('.image_editable', 'mouseenter', function(event) {
    var link = this,
        $link = $(this);
    var trigger = $editTip.data('trigger');
    if(!trigger || (trigger && trigger!=this)) {
      $editTip.data('trigger', this);
      tip.position(event);
      $editTip.fadeOut(0).fadeIn(200);
      var obj = $link.parent();
      var url = '/images/' + id($link.attr('id')) + '/edit';
      $editTip.data('url', url);
    }
  });

  $('body').delegate('.editable.products_list, .editable.products_accordion_list', 'mouseenter', function(event) {
    var link = this,
        $link = $(this);
    var trigger = $editTip.data('trigger');
    if(!trigger || (trigger && trigger!=this)) {
      $editTip.data('trigger', this);
      tip.position(event);
      $editTip.fadeOut(0).fadeIn(200);
      var obj = $link.parent();
      var url = '/containers/' + id(obj.attr('id')) + '/edit';
      $editTip.data('url', url);
    }
  });
    
});
