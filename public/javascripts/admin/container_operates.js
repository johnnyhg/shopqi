var qtip_setting = {
    position: 'topRight',
    hide: { fixed: true }, // Make it fixed so it can be hovered over
    show: { delay: 800 },
    style: { padding: '5px 10px', name: 'green' }
};

jQuery(function($) {
  //$('.container_24 .grid_24:empty').qtip($.extend({content:{url:'/containers/new'}}, qtip_setting));
  $('.grid_1:empty, .grid_2:empty, .grid_3:empty, .grid_4:empty, .grid_5:empty, .grid_6:empty, .grid_7:empty, .grid_8:empty, .grid_9:empty, .grid_10:empty, .grid_11:empty, .grid_12:empty, .grid_13:empty, .grid_14:empty, .grid_15:empty, .grid_16:empty, .grid_17:empty, .grid_18:empty, .grid_19:empty, .grid_20:empty, .grid_21:empty, .grid_22:empty, .grid_23:empty, .grid_24:empty').each(function(){
    $(this).qtip($.extend({ content: { url: '/containers/new', data: { parent_id: id($(this).attr('id')) } }}, qtip_setting));
  });
  $('.grid_1:empty, .grid_2:empty, .grid_3:empty, .grid_4:empty, .grid_5:empty, .grid_6:empty, .grid_7:empty, .grid_8:empty, .grid_9:empty, .grid_10:empty, .grid_11:empty, .grid_12:empty, .grid_13:empty, .grid_14:empty, .grid_15:empty, .grid_16:empty, .grid_17:empty, .grid_18:empty, .grid_19:empty, .grid_20:empty, .grid_21:empty, .grid_22:empty, .grid_23:empty, .grid_24:empty').each(function(){
    $(this).height($(this).prev().height());
  });
  $('.container_operates').qtip($.extend({ content: {url: '/containers/operates' } }, qtip_setting));
});
