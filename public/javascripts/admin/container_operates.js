var container_operates_tooltip_setting = $.extend({}, tooltip_setting, {
  onBeforeShow: function(){
    $('#tooltip').html('正在处理...');
    var obj = this.getTrigger();
    //初始化提示面板的宽高
    this.getTip().width(940);
    this.getTip().height(30);
    $.get('/containers/operates', function(body){
      $('#tooltip').html(body);
    });
  }
});

var container_new_tooltip_setting = $.extend({}, tooltip_setting, {
  onBeforeShow: function(){
    $('#tooltip').html('正在处理...');
    var obj = this.getTrigger();
    //初始化提示面板的宽高
    this.getTip().width(940);
    this.getTip().height(30);
    $.get('/containers/new', { parent_id: id(obj.attr('id')) }, function(body){
      $('#tooltip').html(body);
    });
  }
});

var grid_new_tooltip_setting = $.extend({}, container_new_tooltip_setting, {
  offset: [ -140, 0 ],
  onBeforeShow: function(){
    $('#tooltip').html('正在处理...');
    var obj = this.getTrigger();
    //初始化提示面板的宽高
    this.getTip().width(300);
    this.getTip().height(30);
    $.get('/containers/new', { parent_id: id(obj.attr('id')) }, function(body){
      $('#tooltip').html(body);
    });
  }
});

var container_edit_tooltip_setting = $.extend({}, tooltip_setting, {
  onBeforeShow: function(){
    $('#tooltip').html('正在处理...');
    var obj = this.getTrigger();
    //初始化提示面板的宽高
    this.getTip().width(940);
    this.getTip().height(300);
    $.get('/containers/' + id(obj.attr('id')) + '/edit', function(body){
      $('#tooltip').html(body);
    });
  }
});

jQuery(function($) {
  $('.container_operates').tooltip(container_operates_tooltip_setting).dynamic(dynamic_setting);
  $('.container:empty').tooltip(container_new_tooltip_setting).dynamic(dynamic_setting);
  $('.grid_1:empty, .grid_2:empty, .grid_3:empty, .grid_4:empty, .grid_5:empty, .grid_6:empty, .grid_7:empty, .grid_8:empty, .grid_9:empty, .grid_10:empty, .grid_11:empty, .grid_12:empty, .grid_13:empty, .grid_14:empty, .grid_15:empty, .grid_16:empty, .grid_17:empty, .grid_18:empty, .grid_19:empty, .grid_20:empty, .grid_21:empty, .grid_22:empty, .grid_23:empty, .grid_24:empty').tooltip(grid_new_tooltip_setting);
  $('.grid_1:empty, .grid_2:empty, .grid_3:empty, .grid_4:empty, .grid_5:empty, .grid_6:empty, .grid_7:empty, .grid_8:empty, .grid_9:empty, .grid_10:empty, .grid_11:empty, .grid_12:empty, .grid_13:empty, .grid_14:empty, .grid_15:empty, .grid_16:empty, .grid_17:empty, .grid_18:empty, .grid_19:empty, .grid_20:empty, .grid_21:empty, .grid_22:empty, .grid_23:empty, .grid_24:empty').each(function(){
    $(this).height($(this).prev().height());
  });
  //$('.container').tooltip(container_edit_tooltip_setting).dynamic(dynamic_setting);
});
