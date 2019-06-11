class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.string :product_ids
      t.float :total_price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
