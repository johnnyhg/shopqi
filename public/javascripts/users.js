jQuery(function ($) {
  // close
  $('#main').delegate('.secondary-navigation .close', 'click', function() {
    var $block = $(this).closest('.block');
    $block.slideUp(1000, 'easeInOutCubic', function(){$block.remove();})
  });
});
