// remove id prefix
// example: id('container_111'), will return '111'
function id(str){
  return str.substring(str.lastIndexOf('_') + 1, str.length);
}

// get id prefix
// example: id('container_111'), will return 'container'
function name(str){
  return str.substring(0, str.lastIndexOf('_'));
}

// get id prefix, change to pluralize
// example: id('container_111'), will return 'containers'
function pluralize_name(str){
  str = name(str);
  str += str.match(/s$/) ? 'es' : 's'
  return str;
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
