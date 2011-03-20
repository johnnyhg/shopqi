jQuery(function ($) {
  // close
  $('#main').delegate('.secondary-navigation .close', 'click', function() {
    var $block = $(this).closest('.block');
    $block.slideUp(1000, 'easeInOutCubic', function(){$block.remove();})
  });

  //links
  $('a[data-modal]').live('click', function (e) {
      $("#tooltip").load($(this).attr('href'), function(){ 
        $('#tooltip').modal({minWidth: 300, minHeight: 180});
      });
      e.preventDefault();
  });
});
