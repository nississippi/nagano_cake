class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment: { credit_card: 0, transfer: 1 }
  enum order_status:
    { waitng_for_payment: 0, payment_confirmed: 1,
    in_production: 2, preparing_to_ship: 3, shipped: 4 }

  validates :shipping_name, :shipping_address, :shipping_postal_code, :billing_amount, :payment,
  presence: true

end
