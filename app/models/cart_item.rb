class CartItem < ApplicationRecord
  has_one_attached :image
  belongs_to :item
  belongs_to :customer

  validates :amount, presence: true

  def subtotal
    item.with_tax_price * amount
  end
end
