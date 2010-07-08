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
        $('.editable').effect('highlight');
      }, 'script');
    }
  });
});
