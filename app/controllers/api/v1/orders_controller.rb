class Api::V1::OrdersController < ApplicationController
	before_action :check_login, only:[:create, :index]

	def index 
		render json: OrderSerializer.new(current_user.orders).serializable_hash 
	end

	def show 
		order = current_user.orders.find(params[:id])
		if order 
			options = { include: [:products]}
			render json: OrderSerializer.new(order, options).serializable_hash
		else 
			head 404
		end
	end

	def create 
		order = current_user.orders.build(order_params)
		  if order.save
		  	render json: order, status: :ok
		  else 
		  	render json: order.errors, status: 422
		  end 
	end 

	private 
	def order_params
		params.require(:order).permit(:total, products_ids: [])
	end 
end
