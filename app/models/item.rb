class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :image, presence: true

  def tax_included_price
    (price * 1.1).floor
  end

  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end
end
