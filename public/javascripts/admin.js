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
  offset: [5, 2],
  effect: 'slide',
  //delay: 0,
  //opacity: 0.9,
  onBeforeShow: function(){
    $('#tooltip').html('正在处理...');
    var obj = this.getTrigger().parent();
    var url = obj.attr('edit-type') + '/' + obj.attr('edit-id') + '/edit.js';
    $.get(url, function(body){
      $('#tooltip').html(body);
      $('#tooltip :text:first').focus();
    });
  }
};

var dynamic_setting = { bottom: { direction: 'down', bounce: true } };

jQuery(function ($) {
  //show user's panel
  $('.editable a').tooltip(tooltip_setting).dynamic(dynamic_setting);

  $('.editable').sortable({
    update: function(){
      $.post('/navs/sort', $('.editable').sortable('serialize'), function(){
        $("#navs li:first").addClass('no_bar');
        $("#navs li:gt(0)").removeClass('no_bar');
      }, 'script');
    }
  });
});
