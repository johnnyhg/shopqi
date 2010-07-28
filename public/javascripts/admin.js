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
  //delay: 100,
  //position: ['center','right'],
  //offset: [top, left]
  offset: [15, 2],
  effect: 'slide',
  //鼠标移至触发点时显示，移出时隐藏
  //鼠标移至提示面板时显示，移出时不隐藏，手动点击取消隐藏
  events: {
    def: 'mouseover,mouseout',
    tooltip: 'mouseover'
  },
  //opacity: 0.9,
  onBeforeShow: function(){
    $('#tooltip').html('正在处理...');
    var obj = this.getTrigger().parent();
    //初始化提示面板的宽高
    if(obj.attr('edit-width'))
      this.getTip().width(obj.attr('edit-width'));
    if(obj.attr('edit-height'))
      this.getTip().height(obj.attr('edit-height'));

    //新增还是修改
    var url = obj.attr('edit-type') + '/new';
    if(obj.attr('edit-id'))
      url = obj.attr('edit-type') + '/' + obj.attr('edit-id') + '/edit';

    //处理完后需要更新的节点
    if(obj.attr('relate_dom_id'))
      url += "?relate_dom_id=" + obj.attr('relate_dom_id');

    //处理完后的回调路径，用于关联Image
    if(obj.attr('callback_url'))
      url += "&callback_url=" + obj.attr('callback_url');

    $.get(url, function(body){
      $('#tooltip').html(body);
      var contrainer = $('#tooltip :first-child');
      //背景色，提示面板大小由具体的显示页面控制
      //$('#tooltip').css('background-color', contrainer.css('background-color')).width(contrainer.width()).height(contrainer.height());
      //$('#tooltip').css('background-color', contrainer.css('background-color'));
      $('#tooltip :text:first').focus();
    });
  }
};

//显示提示层动态调整
var dynamic_setting = { bottom: { direction: 'down', bounce: true } };

jQuery(function ($) {
  //show panel
  $('.editable a').tooltip(tooltip_setting).dynamic(dynamic_setting);
  //$('.editable a').tooltip(tooltip_setting);

  $('.sortable').each(function(){
    $(this).sortable({
      update: function(){
        //$.jGrowl($(this).html(), {sticky: true});
        $.post($(this).attr('sort_url'), $(this).sortable('serialize'), null, 'script');
      }
    });
  });

  //$("ul#nav li a.dom_indexmenu").css('background-image', 'none');
});
