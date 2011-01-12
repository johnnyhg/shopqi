jQuery(function ($) {
  var jug = new Juggernaut();

  jug.subscribe("tasks", function(data){ 
    $('#tasks').append(data['task']);
  });
});
