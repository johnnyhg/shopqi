# encoding: utf-8
class PaymentsController < ApplicationController
  respond_to :json
  prepend_before_filter :authenticate_user!
  can_edit_on_the_spot

  def update_attribute_on_the_spot
    klass, field, id = params[:id].split('__')
    payment = store.payments.where(:payment_type_id => id).first
    attrs = {:payment_type_id => id, field => params[:value]}
    if payment
      payment.update_attributes(attrs) 
    else
      payment = store.payments.create(attrs)
    end
    render :text => payment.send(field)
  end
  
  def index
    @payment_types = PaymentType.all_in(store)
  end

end
