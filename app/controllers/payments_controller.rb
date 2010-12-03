# encoding: utf-8
class PaymentsController < ApplicationController
  respond_to :html,:json
  protect_from_forgery :except => [:post_data]
  prepend_before_filter :authenticate_user!

  def post_data
    message=""
    payment = store.payments.where(:payment_type_id => params[:id]).first
    attrs = {:payment_type_id => params[:id], :is_show => params[:is_show], :account => params[:account], :partnerid => params[:partnerid], :verifycode => params[:verifycode]}
    payment ? payment.update_attributes(attrs) : store.payments.create(attrs)
    #render :json => [true]
    render :nothing => true
  end
  
  
  def index
    index_columns ||= [:name, :is_show, :account, :partnerid, :verifycode]
    @payments = PaymentType.all_in(store)
    render :json => @payments.to_jqgrid_json(index_columns, 1, 100, @payments.size)
  end

end
