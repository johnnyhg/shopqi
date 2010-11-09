// 购物车
var Car = {
  add: function(){
    var data = { };
    data['quantity'] = $('#quantity').val();
    $.post(window.location.pathname + '/add_to_car.js', data, null, 'script');
  },
  
  order: function(){
    var address_id = $('#address_panel input:radio:checked').val();
    var delivery = $('#delivery_panel input:radio:checked').val();
    var pay = $('#pay_panel input:radio:checked').val();
    var receive = $('#receive_panel input:radio:checked').val();
    var description= $('#description').val();
    var data = { };
    data['order'] = {address_id: address_id, delivery: delivery, pay: pay, receive: receive, description: description};
    $.post('/member/orders', data, null, 'script');
  }
}
