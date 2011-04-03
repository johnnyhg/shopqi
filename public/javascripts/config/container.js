Container = {
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
      }
    });
  },

  // 移动容器：调整move handler位置
  move: function(){
    // 容器存在兄弟容器(非辅助)
    if(($(this).parent().parent().children('.container:not(.assist)').size() > 1) && (!$(this).parent().hasClass('assist'))){
      var position = $(this).parent().position();
      $(this).css('left', position.left).css('top', position.top).show();
    }
  },

  // 生成move handler
  generate_move_handler: function(){
    //$('.container').each(function(){
    //  if(!$(this).children('h2.move')[0]) $(this).prepend($('<h2 class="move"/>').css('opacity', '0.3'));
    //});
    //$('h2.move').each(Container.move);
  }
};

jQuery(function($) {

  //空白处要显示提示面板，用于继续添加容器
  //逐层将高度调整（保持与顶层容器一致），除非容器已无子容器
  $('#content .container_24 > .grid_24').each(Container.generate_assist);

  //容器排序move handler
  $('h2.move').live('mouseenter', function(){ $(this).css('opacity', '1'); }).live('mouseleave', function(){ $(this).css('opacity', '0.3'); });

});
