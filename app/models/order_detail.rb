class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum crafting_status: { unable_to_start: 0, waiting_production: 1, in_production: 2, complete: 3 }

  def subtotal
    tax_included_price * amount
  end
end
