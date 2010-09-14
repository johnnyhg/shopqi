//首页
$(document).ready(function(){
  //下拉菜单
  $("#nav li").hover(function(){
    $('dl', this).show();
  }, function(){
    $('dl', this).hide();
  });

});
