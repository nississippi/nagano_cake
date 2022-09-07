class CartItem < ApplicationRecord
  has_one_attached :image
  belongs_to :item
  belongs_to :customer

  validates :amount, presence: true

  def subtotal
    item.tax_included_price * amount
  end
end
