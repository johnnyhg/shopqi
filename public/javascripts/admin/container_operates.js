var container_operates_tooltip_setting = {
  tip: '#tooltip', 
  predelay: 1000, 
  delay: 800,
  offset: [15, 2],
  effect: 'slide',
  //opacity: 0.9,
  onBeforeShow: function(){
    $('#tooltip').html('正在处理...');
    var obj = this.getTrigger();
    //初始化提示面板的宽高
    this.getTip().width(960);
    this.getTip().height(30);
    $.get('/containers/operates', function(body){
      $('#tooltip').html(body);
    });
  }
};

var container_edit_tooltip_setting = {
  tip: '#tooltip', 
  predelay: 1000, 
  delay: 800,
  offset: [15, 2],
  effect: 'slide',
  events: {
    def: 'mouseover,mouseout',
    tooltip: 'mouseover,cancle'
  },
  //opacity: 0.9,
  onBeforeShow: function(){
    $('#tooltip').html('正在处理...');
    var obj = this.getTrigger();
    //初始化提示面板的宽高
    this.getTip().width(960);
    this.getTip().height(300);
    $.get('/containers/' + id(obj.attr('id')) + '/edit', function(body){
      $('#tooltip').html(body);
    });
  }
};

jQuery(function($) {
  $('.container_operates').tooltip(container_operates_tooltip_setting).dynamic(dynamic_setting);
  $('.container').tooltip(container_edit_tooltip_setting).dynamic(dynamic_setting);
});
