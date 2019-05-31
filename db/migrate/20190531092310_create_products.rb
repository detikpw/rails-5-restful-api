class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.string :image

      t.timestamps
    end
    add_index :products, :slug
  end
end
