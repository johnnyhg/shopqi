var qtip_setting = {
    position: 'topRight',
    hide: { fixed: true }, // Make it fixed so it can be hovered over
    show: { delay: 800 },
    style: { padding: '5px 10px', name: 'green' }
};

jQuery(function($) {
  $('.container_operates').qtip($.extend({ content: {url: '/containers/operates' } }, qtip_setting));
  //$('.container_24 .grid_24:empty').qtip($.extend({content:{url:'/containers/new'}}, qtip_setting));
  $('.grid_1:empty, .grid_2:empty, .grid_3:empty, .grid_4:empty, .grid_5:empty, .grid_6:empty, .grid_7:empty, .grid_8:empty, .grid_9:empty, .grid_10:empty, .grid_11:empty, .grid_12:empty, .grid_13:empty, .grid_14:empty, .grid_15:empty, .grid_16:empty, .grid_17:empty, .grid_18:empty, .grid_19:empty, .grid_20:empty, .grid_21:empty, .grid_22:empty, .grid_23:empty, .grid_24:empty').each(function(){
    $(this).qtip($.extend({ content: { url: '/containers/new', data: { parent_id: id($(this).attr('id')) } }}, qtip_setting));
  });

  //空白处要显示提示面板，用于继续添加容器
  //逐层将高度调整（保持与顶层容器一致），除非容器已无子容器
  $('#content .container_24 > .grid_24').each(function(){
    var root = $(this);
    $.jGrowl(root.height());
    var container_height = root.height();
    root.children('.container').each(function(){
      var child = $(this);
      if(child.children('.container')[0]){
        child.height(root.height());
      }
      var children_height = 0;
      child.children('.container').each(function(){
        children_height += $(this).height();
      });
      //填充空白
      if(root.height() - children_height > 0){
        var rest_height = root.height() - children_height;
        child.children('.container').eq(0).clone().empty().appendTo(child).height(rest_height).removeAttr('id');
      }
    });
  });

  //$('.grid_1:empty, .grid_2:empty, .grid_3:empty, .grid_4:empty, .grid_5:empty, .grid_6:empty, .grid_7:empty, .grid_8:empty, .grid_9:empty, .grid_10:empty, .grid_11:empty, .grid_12:empty, .grid_13:empty, .grid_14:empty, .grid_15:empty, .grid_16:empty, .grid_17:empty, .grid_18:empty, .grid_19:empty, .grid_20:empty, .grid_21:empty, .grid_22:empty, .grid_23:empty, .grid_24:empty').each(function(){
  //  $(this).height($(this).prev().height());
  //});
});
