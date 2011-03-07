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

Admin = {
  refresh: function(){
    //accordion products list
    $('.accordion').accordion();

    //hots
    if($('dd ul:empty')[0]){
      var parentDl = $('dd ul:empty').parents('dl:first');
      //qtip_ul为方便destroy qtip
      $('dd ul:empty').not('qtip_ul').addClass('qtip_ul').height(parentDl.height()).qtip($.extend({ content: {url: '/hots/operates' , data: { parent_id: id(parentDl.attr('id')) } }}, qtip_setting));
    }

    //sort
    $('.sortable').removeClass('sortable').each(function(){
      var attrs = {
        // 辅助面板不可拖动
        items: '>:not(.assist)',
        update: function(event, ui){
          //$.jGrowl($(this).html(), {sticky: true});
          $.post($(this).attr('sort_url'), $(this).sortable('serialize'), null, 'script');
          // 轮播广告拖动后需要调整图片的位置
          ui.item.trigger('sortable.update');
        }
      };
      // 容器拖动时的move handler
      if($(this).hasClass('container')) attrs['handle'] = 'h2';
      $(this).sortable(attrs);
    });

    //延时以使图片加载后固定高度
    window.setTimeout(Container.generate_move_handler, 1000);
  }
};

jQuery(function ($) {
  Admin.refresh();

  // 商品详情即时编辑
  $('.editinplace').each(function(){
    var $this = $(this);
    $this.editable(
      //target为url时提交至服务器，为function则本地执行
      function(text, settings){
        var data = { _method: 'put' };
        data[rest_name()] = {};
        data[rest_name()][$this.attr('data-name')] = text;
        $.post(window.location.pathname + '.js', data);
        return text;
      },{
      //失焦时提交
      onblur : 'submit',
      //input为inline,则form也应为inline,否则布局会乱
      cssclass : 'form_inline',
      placeholder: '未命名'
    });
  });

  $(document).click(function(){
    $('.panel').hide(500);
    $('.wysiwyg').css('border-color', 'white');
  });

  //修正:点击菜单面板会触发document click事件
  $('.panel').click(function(e){
    e.stopPropagation();
  });
});
