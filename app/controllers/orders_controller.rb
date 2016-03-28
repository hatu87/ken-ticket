class OrdersController < ApplicationController

  def create
    order = Order.checkout(current_user, params[:types])
    # binding.pry
    if order.nil?
      flash[:error] = 'Cannot book order'
      redirect_to new_event_ticket_path(params[:event_id])
    else
      redirect_to action: :show, id: order.id
    end


  end

  def show
    @order = Order.find_by(id: params[:id])
  end
end
