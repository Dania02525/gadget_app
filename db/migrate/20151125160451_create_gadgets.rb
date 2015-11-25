class CreateGadgets < ActiveRecord::Migration
  def change
    create_table :gadgets do |t|
      t.string :name
      t.integer :price
      t.integer :inventory, default: 0

      t.timestamps null: false
    end
  end
end
