class CombineItemsInCart < ActiveRecord::Migration
  def up
  	Cart.all.each do ||
  		sums = cart.line_items.group(:product).sum(:quantity)
  		sums.each do |product_id, quantity|
  			if quantity > 1
  				cart.line_items.where(:product_id => product_id).delete_all
  				cart.line_items.create(:product_id=>product_id, :quantity=>quantity)
  			end
  		end
  	end
  end

  def down
    LineItem.where("quantity>1" ).each do |lineitem|
      lineitem.quantity.times do
        LineItem.create :cart_id=>lineitem.cart_id,
          :product_id=>lineitem.product_id, :quantity=>1
      end

      lineitem.destroy
    end
   end
end
