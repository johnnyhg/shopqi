jQuery(function ($) {
    $('a[data-remote]').live('ajax:success', function(xhr, data, status) {
        var update = $(this).attr('update');
        $('#' + update).html(data);
    });
});
