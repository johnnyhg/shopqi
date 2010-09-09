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
    var obj = this.getTrigger().parents('[id]:first');
    //初始化提示面板的宽高
    var width = 300, height = 130;
    if(obj.attr('edit_width')) width = parseInt(obj.attr('edit_width'));
    if(obj.attr('edit_height')) height = parseInt(obj.attr('edit_height'));
    this.getTip().width(width);
    this.getTip().height(height);

    var data = {};

    //jquery tooltip只负责修改，qtip负责新增
    var url = pluralize_name(obj.attr('id')) + '/' + id(obj.attr('id')) + '/edit';

    //所属容器
    var container = this.getTrigger().parents('.container');
    if(container[0])
      data['container_id'] = id(container.attr('id'));

    //处理完后需要更新的节点
    if(obj.attr('relate_dom_id'))
      url += "?relate_dom_id=" + obj.attr('relate_dom_id');

    //处理完后的回调路径，用于关联Image
    if(obj.attr('callback_url'))
      url += "&callback_url=" + obj.attr('callback_url');

    $.get(url, data, function(body){
      $('#tooltip').html(body);
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

    if($('dd ul:empty')[0]){
      var parentDl = $('dd ul:empty').parents('dl:first');
      //qtip_ul为方便destroy qtip
      $('dd ul:empty').not('qtip_ul').addClass('qtip_ul').height(parentDl.height()).qtip($.extend({ content: {url: '/hots/operates' , data: { parent_id: id(parentDl.attr('id')) } }}, qtip_setting));
    }

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
  // tooltip设置显示延时，但关闭不能也跟着延时
  $('#tooltip').bind('cancle', function(){ $(this).hide() });
  Admin.refresh();
});
