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
  $('.container').tooltip(container_new_tooltip_setting).dynamic(dynamic_setting);
  //$('.container').tooltip(container_edit_tooltip_setting).dynamic(dynamic_setting);
});
