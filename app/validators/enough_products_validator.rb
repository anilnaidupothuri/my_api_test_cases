class EnoughProductsValidator < ActiveModel::Validator
	def validate(record)
		record.placements.each do |placement|
			product = placement.product
			if placement.quantity > product.quantity
			record.errors[product.title.to_s] << "Is out of stock, just #{product.quantity} availble"

			end
		end
	end 
end  