//首页
$(document).ready(function(){
  //下拉菜单
  $("#nav li").hover(function(){
    $('dl', this).show();
  }, function(){
    $('dl', this).hide();
  });

  //右侧手风琴效果
  $("dl.accshowlist").each(function() {
    var self = this;
    var classname = "showpic";
    $("dd:last", self).show();
    $("dt:last", self).addClass(classname);
    $("dt", self).mouseover(function() {
      if (!$(this).hasClass(classname)) {
        $("dt", self).removeClass(classname);
        $(this).addClass(classname);
        $("dd", self).hide();
        $(this).next().show();
      }
    });
  });

});
