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
  //position: ['center','right'],
  //offset: [top, left]
  offset: [15, 2],
  effect: 'slide',
  //delay: 0,
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

    $.get(url, function(body){
      $('#tooltip').html(body);
      var contrainer = $('#tooltip :first-child');
      //背景色，提示面板大小由具体的显示页面控制
      //$('#tooltip').css('background-color', contrainer.css('background-color')).width(contrainer.width()).height(contrainer.height());
      $('#tooltip').css('background-color', contrainer.css('background-color'));
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

  $('.sortable').sortable({
    update: function(){
      $.post('/navs/sort', $('.sortable').sortable('serialize'), function(){
        $("#navs li:first").addClass('no_bar');
        $("#navs li:gt(0)").removeClass('no_bar');
      }, 'script');
    }
  });

});
