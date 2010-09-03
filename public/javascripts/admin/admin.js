// jQuery extension
// 将内容添加至当前节点的前面或后面
// @param direct 移动的方向('above', 'below')
// @param content 待添加的内容
$.fn.move = function(direct, content){
  this.each(function(){
      if(direct == 'above'){
        $(this).before(content);
      }else{
        $(this).after(content);
      }
  });
}

var tooltip_setting = {
  tip: '#tooltip', 
  predelay: 1000, 
  delay: 800,
  //position: ['center','right'],
  //offset: [top, left]
  offset: [15, 2],
  effect: 'slide',
  //鼠标移至触发点时显示，移出时隐藏
  //鼠标移至提示面板时显示，移出时不隐藏，手动点击取消隐藏(即触发cancle事件，注意直接调用hide会导致此后无法显示提示)
  events: {
    def: 'mouseover,mouseout',
    tooltip: 'mouseover,cancle'
  },
  //opacity: 0.9,
  onBeforeShow: function(){
    $('#tooltip').html('正在处理...');
    var obj = this.getTrigger().parent();
    //初始化提示面板的宽高
    if(obj.attr('edit_width'))
      this.getTip().width(parseInt(obj.attr('edit_width')));
    if(obj.attr('edit_height'))
      this.getTip().height(parseInt(obj.attr('edit_height')));

    var data = {};

    //新增还是修改
    var url = name(obj.attr('id')) + '/new';
    if(obj.attr('id'))
      url = name(obj.attr('id')) + '/' + id(obj.attr('id')) + '/edit';

    //所属容器
    var container = this.getTrigger().parents('.container');
    data['container_id'] = id(container.attr('id'));

    //处理完后需要更新的节点
    if(obj.attr('relate_dom_id'))
      url += "?relate_dom_id=" + obj.attr('relate_dom_id');

    //处理完后的回调路径，用于关联Image
    if(obj.attr('callback_url'))
      url += "&callback_url=" + obj.attr('callback_url');

    $.get(url, data, function(body){
      $('#tooltip').html(body);
      var contrainer = $('#tooltip :first-child');
      //背景色，提示面板大小由具体的显示页面控制
      //$('#tooltip').css('background-color', contrainer.css('background-color')).width(contrainer.width()).height(contrainer.height());
      //$('#tooltip').css('background-color', contrainer.css('background-color'));
      $('#tooltip :text:first').focus();
    });
  }
};

var image_tooltip_setting = $.extend({}, tooltip_setting, {
  onBeforeShow: function(){
    this.getTip().width(960);
    this.getTip().height(this.getTrigger().height() + 70);
    var url = '/images/' + id(this.getTrigger().attr('id')) + '/edit';
    $.get(url, function(body){
      $('#tooltip').html(body);
    });
  }
});

//显示提示层动态调整
var dynamic_setting = { bottom: { direction: 'down', bounce: true } };

Admin = {
  refresh: function(){
    //show panel
    $('.editable a').tooltip(tooltip_setting).dynamic(dynamic_setting);
    $('.editable').removeClass('editable');

    //image
    $('.image_editable').removeClass('image_editable').tooltip(image_tooltip_setting).dynamic(dynamic_setting);

    //sort
    $('.sortable').removeClass('sortable').each(function(){
      $(this).sortable({
        update: function(event, ui){
          //$.jGrowl($(this).html(), {sticky: true});
          $.post($(this).attr('sort_url'), $(this).sortable('serialize'), null, 'script');
          // 轮播广告拖动后需要调整图片的位置
          ui.item.trigger('sortable.update');
        }
      });
    });
  }
};

jQuery(function ($) {
  Admin.refresh();
});
