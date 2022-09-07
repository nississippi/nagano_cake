class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :last_name, :last_name_kana, :first_name, :first_name_kana,
    :postal_code, :address, :telephone_number, presence: true

  def full_name
    last_name + first_name
  end
end
