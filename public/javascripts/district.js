var selects = $('#region select');
selects.change(function(){
  var $this = this;
  var select_index = selects.index($this);
  var select = selects.eq(select_index + 1);
  if($(this).val() != '' && select[0]){
    $.get('/district/' + $(this).val(), function(data){
      result = eval(data);
      var options = select.attr('options');
      $('option:gt(0)', select).remove();
      $.each(result, function(i, item) {
        options[options.length] = new Option(item[0], item[1]);
      });
    });
  }
});
