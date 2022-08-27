class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.references :item_id, null: false, foreign_key: true
      t.references :customer_id, null: false, foreign_key: true
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
