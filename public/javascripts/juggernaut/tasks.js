jQuery(function ($) {
  $('#footbar').footbar();
  var jug = new Juggernaut();

  jug.subscribe("tasks/" + store_id, function(data){ 
    $('#taskTemplate').tmpl(data).appendTo('#tasks');
  });
});
