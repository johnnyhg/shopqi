//---------- start index focus
function index_focus_change()
{
  var self_now = 0;
  var self_speed = 5000;
  var self_auto_change = null;
  var self_max = $('#index_focus_box div.img').size();
  function self_change(i)
  {
          $('#index_focus_box div.img').hide();
          $('#index_focus_txt_bg li').removeClass('on');
          $('#index_focus_txt li').removeClass('on');
          $('#index_focus_box div.img:eq(' + i + ')').show();
          $('#index_focus_txt_bg li:eq(' + i + ')').addClass('on');
          $('#index_focus_txt li:eq(' + i + ')').addClass('on');
  }
  function self_interval()
  {
          return setInterval(function(){
                  self_now++;
                  if (self_now >= self_max)
                  {
                          self_now = 0;
                  }
                  self_change(self_now);
          }, self_speed);
  }
  $('#index_focus_box div:first').show();
  $('#index_focus_txt_bg li:first').addClass('on');
  $('#index_focus_txt li:first').addClass('on');
  $('#index_focus_txt li').each(function(i)
  {
          $(this).mouseover(function(){
                  self_now = i;
                  clearInterval(self_auto_change);
                  self_change(i);
          }).mouseout(function(){
                  self_auto_change = self_interval();
          });
  });
  $(function(){
          $('#index_focus_loding').hide();
          self_auto_change = self_interval();
  });
}
index_focus_change();
//---------- end index focus
