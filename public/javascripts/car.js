// 购物车
var Car = {
  add: function(){
    var data = { };
    data['quantity'] = $('#quantity').val();
    $.post(window.location.pathname + '/add_to_car.js', data, null, 'script');
  },
  
  order: function(){
    $.post('/orders', null, null, 'script');
  }
}
