/*!
 * jquery.onetip. The jQuery edit link plugin
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
/**
 * @param selector: jquery selector，delegate with mouseenter event
 * @param label: one tip button show text
 * @param function: return url, while the button was click, send the ajax request to this url
 */
jQuery.onetip = function(selector){
  if(!$('#onetip')[0]){
    $('#loading-indicator').ajaxStart(function(){$(this).show()}).ajaxStop(function(){$(this).hide()});
    $('<div id="onetip"><div><a href="#">编辑</a></div></div>').hide().appendTo('body');
    //点击按钮
    $('a', $('#onetip')).mousedown(function(){
      $("#tooltip").load($('#onetip').data('url'), function(){ 
        $('#tooltip').modal({minWidth: 300, minHeight: 180});
      });
    });
    $(document).mousedown(function(){ $('#onetip').hide().removeData('trigger'); });
  }

  var url_function = arguments[arguments.length-1];
  var label = (arguments.length == 2) ? '编辑' : arguments[1];

  //突出背景
  $('body').delegate(selector, 'mouseenter mouseleave', function(event) {
    $(this).toggleClass('relative_element');
  });

  //显示按钮
  $('body').delegate(selector, 'mouseenter', function(event) {
    var trigger = $('#onetip').data('trigger');
    if(!trigger || (trigger && trigger!=this)) {
      $('a', $('#onetip')).text(label);
      $('#onetip').data('trigger', this).css({
        top: event.pageY - $('#onetip').outerHeight()/2 + 15,
        left: event.pageX - $('#onetip').outerWidth()/2
      }).fadeOut(0).fadeIn(200).data('url', url_function.apply(this));
    }
  });
}


jQuery(function ($) {

  //导航等链接
  $.onetip('.editable > a', function() {
    //hot id show in ancestor dl elment
    var objId = $(this).parent().closest('*[id]').attr('id');
    var url = pluralize_name(objId) + '/' + id(objId) + '/edit';
    return url;
  });

  //图片
  $.onetip('.image_editable', function() {
    var url = '/images/' + id($(this).attr('id')) + '/edit';
    return url;
  });

  //商品列表
  $.onetip('.editable.products_list, .editable.products_accordion_list', function() {
    var url = '/containers/' + id($(this).parent().attr('id')) + '/edit';
    return url;
  });

  //空白容器
  $.onetip('.grid_1:empty, .grid_2:empty, .grid_3:empty, .grid_4:empty, .grid_5:empty, .grid_6:empty, .grid_7:empty, .grid_8:empty, .grid_9:empty, .grid_10:empty, .grid_11:empty, .grid_12:empty, .grid_13:empty, .grid_14:empty, .grid_15:empty, .grid_16:empty, .grid_17:empty, .grid_18:empty, .grid_19:empty, .grid_20:empty, .grid_21:empty, .grid_22:empty, .grid_23:empty, .grid_24:empty', '添加', function(){
    var url = '/containers/new?parent_id=' + id($(this).attr('id'));
    return url;
  });
    
});
