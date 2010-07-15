/*
 * jqDnR - Minimalistic Drag'n'Resize for jQuery.
 *
 * Copyright (c) 2007 Brice Burgess <bhb@iceburg.net>, http://www.iceburg.net
 * Licensed under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * $Version: 2007.08.19 +r2
 *
 * 2010.07.12 by saberma
 * support inside container
 */

(function($){
$.fn.jqDrag=function(h, c){return i(this,h,c,'d');};
$.fn.jqResize=function(h, c){return i(this,h,c,'r');};
$.jqDnR={dnr:{},e:0,
drag:function(v){
 //if(M.k == 'd')E.css({left:M.X+v.pageX-M.pX,top:M.Y+v.pageY-M.pY});
 if(M.k == 'd'){
  var x = M.X+v.pageX-M.pX;
  var y = M.Y+v.pageY-M.pY;
  x = (x < 0) ? 0 : x;
  x = (x > P.W - M.W) ? P.W-M.W : x;
  y = (y < 0) ? 0 : y;
  y = (y > P.H - M.H) ? P.H-M.H : y;
  //$('#log').text("x:" + x + "(" + P.X + ")  y:" + y + "(" + P.Y + ")");
  E.css({left:x,top:y});
 }else E.css({width:Math.max(v.pageX-M.pX+M.W,0),height:Math.max(v.pageY-M.pY+M.H,0)});
  return false;},
stop:function(){E.css('opacity',M.o);$(document).unbind('mousemove',J.drag).unbind('mouseup',J.stop);}
};
var J=$.jqDnR,M=J.dnr,E=J.e,P=$(document),
i=function(e,h,c,k){return e.each(function(){h=(h)?$(h,e):e;
 c = $(c);
 h.bind('mousedown',{e:e,k:k},function(v){var d=v.data,p={};E=d.e;
 // attempt utilization of dimensions plugin to fix IE issues
 if(E.css('position') != 'relative'){try{E.position(p);}catch(e){}}
 M={X:p.left||f('left')||0,Y:p.top||f('top')||0,W:E.width(),H:E.height(),pX:v.pageX,pY:v.pageY,k:d.k,o:E.css('opacity')};
 E.css({opacity:0.8});$(document).mousemove($.jqDnR.drag).mouseup($.jqDnR.stop);
 P={X:c.position().left,Y:c.position().top,W:c.width(),H:c.height()};
 return false;
 });
});},
f=function(k){return parseInt(E.css(k))||false;};
})(jQuery);
