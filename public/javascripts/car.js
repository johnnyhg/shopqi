// 购物车
var Car = {
  // 添加至购物车
  add: function(){
    var data = { };
    data['quantity'] = $('#quantity').val();
    $.post(window.location.pathname + '/add_to_car.js', data, null, 'script');
  },
  
  // 提交订单
  order: function(){
    var address_id = $('#address_panel input:radio:checked').val();
    var delivery = $('#delivery_panel input:radio:checked').val();
    var pay = $('#pay_panel input:radio:checked').val();
    var receive = $('#receive_panel input:radio:checked').val();
    var description= $('#description').val();
    var data = { };
    data['order'] = {address_id: address_id, delivery: delivery, pay: pay, receive: receive, description: description};
    $.post('/member/orders', data, null, 'script');
  },

  // 支付
  pay: function(id, price_sum){
    $('#out_trade_no').val(id);
    $('#total_fee').val(price_sum);
    $('#show_url').val($('#show_url').val() + '/' + id);
    $('#payment_form').submit();
  }
}
