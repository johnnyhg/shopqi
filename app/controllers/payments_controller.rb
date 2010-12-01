# encoding: utf-8
class PaymentsController < ApplicationController
  respond_to :html,:json
  protect_from_forgery :except => [:post_data]

  def post_data
    message=""
    payment = store.payments.where(:payment_type_id => params[:id]).first
    attrs = {:payment_type_id => params[:id], :account => params[:account], :partnerid => params[:partnerid], :verifycode => params[:verifycode]}
    payment ? payment.update_attributes(attrs) : store.payments.create(attrs)
    #render :json => [true]
    render :nothing => true
  end
  
  
  def index
    index_columns ||= [:name, :account, :partnerid, :verifycode]

    @payments=PaymentType.all
    total_entries=@payments.size

    @payments.each {|payment| payment.account_in(store)}
    
    render :json => @payments.to_jqgrid_json(index_columns, 1, 100, total_entries)
  end

end
