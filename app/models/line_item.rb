class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id
  belongs_to :product
  belongs_to :cart

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

end
