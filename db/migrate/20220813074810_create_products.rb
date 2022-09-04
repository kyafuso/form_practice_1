class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.integer :price, null: false
      t.boolean :availability, null: false

      t.timestamps
    end
  end
end
