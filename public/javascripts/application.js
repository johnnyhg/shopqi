// remove id prefix
// example: id('container_111'), will return '111'
function id(str){
  return str.substring(str.lastIndexOf('_') + 1, str.length);
}

jQuery(function ($) {
  // remote anchor support update attribute
  $('a[data-remote]').live('ajax:success', function(xhr, data, status) {
    var update = $(this).attr('update');
    if(update){
      $('#' + update).html(data);
      $('#' + update + ' :text:first').focus();
    }
  });
});
