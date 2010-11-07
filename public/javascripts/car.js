// 购物车
var Car = {
  add: function(){
    var data = { };
    data['quantity'] = $('#quantity').val();
    $.post(window.location.pathname + '/add_to_car.js', data, null, 'script');
  },
  
  order: function(){
    var address_id = $('#address_panel input:radio:checked').val();
    var data = { };
    data['order'] = {address_id: address_id};
    $.post('/member/orders', data, null, 'script');
  }
}
