var qtip_setting = {
    position: 'topLeft',
    hide: { fixed: true }, // Make it fixed so it can be hovered over
    show: { delay: 800 },
    style: { padding: '5px 10px', name: 'green' }
};

Container = {
  attach_tip: function(){
    $('.grid_1:empty, .grid_2:empty, .grid_3:empty, .grid_4:empty, .grid_5:empty, .grid_6:empty, .grid_7:empty, .grid_8:empty, .grid_9:empty, .grid_10:empty, .grid_11:empty, .grid_12:empty, .grid_13:empty, .grid_14:empty, .grid_15:empty, .grid_16:empty, .grid_17:empty, .grid_18:empty, .grid_19:empty, .grid_20:empty, .grid_21:empty, .grid_22:empty, .grid_23:empty, .grid_24:empty').each(function(){
      // qtip_container用于添加子容器后调用destroy
      $(this).addClass('qtip_container').qtip($.extend({ content: { url: '/containers/new', data: { parent_id: id($(this).attr('id')) } }}, qtip_setting));
    });
  },

  //删除原有辅助容器及其提示面板
  destroy_assist: function(){
    //destroy old qtip
    var root = $(this).parents('.container_24 > .grid_24');
    root.find('.assist').remove();
    root.find('.qtip_container').andSelf().filter('.qtip_container').removeClass('qtip_container').qtip('destroy');
  },

  // 生成辅助容器
  generate_assist: function(){
    var root = $(this).parent('.container_24')[0] ? $(this) : $(this).parents('.container_24 > .grid_24');
    //清除原有高度属性
    //TODO: 只去掉height属性，而不删除整个style属性
    root.find('.container').removeAttr('style');
    var root_grids = 24;
    var container_height = root.height();

    //横向辅助容器
    var children_grids = 0;
    root.children('.container').each(function(){
      children_grids += parseInt($(this).attr('class').match(/grid_(\d{1,2})/)[1]);
    });
    //填充空白
    if(root_grids - children_grids > 0){
      var rest_grids = root_grids - children_grids;
      //辅助容器的id为父容器的id，并在其前加上assist_
      $('<div/>').appendTo(root).addClass('assist').addClass('grid_' + rest_grids).addClass('omega').attr('id', 'assist_' + root.attr('id')).height(container_height);
      Container.attach_tip();
    }

    //纵向辅助容器
    root.children('.container').each(function(){
      var child = $(this);
      if(child.children('.container')[0]){
        child.height(container_height);
      }
      var children_height = 0;
      child.children('.container').each(function(){
        children_height += $(this).height();
      });
      //填充空白
      if(container_height - children_height > 0){
        var rest_height = container_height - children_height;
        //辅助容器的id为父容器的id，并在其前加上assist_
        child.children('.container').eq(0).clone().empty().appendTo(child).height(rest_height).addClass('assist').attr('id', 'assist_' + child.attr('id'));
        Container.attach_tip();
      }
    });
  },

  // 移动容器：调整move handler位置
  move: function(){
    var position = $(this).parent().position();
    $(this).css('left', position.left).css('top', position.top).show();
  }
};

jQuery(function($) {
  $('.container_operates').qtip($.extend({ content: {url: '/containers/new' } }, qtip_setting));
  //点击后立即关闭提示面板
  $('.qtip a').live('click', function(){
    $(this).parents('.qtip').qtip('hide');
  });

  Container.attach_tip();

  //空白处要显示提示面板，用于继续添加容器
  //逐层将高度调整（保持与顶层容器一致），除非容器已无子容器
  $('#content .container_24 > .grid_24').each(Container.generate_assist);

});
