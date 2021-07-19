class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :product_name,        null: false
      t.text :description,           null: false
      t.integer :price,              null: false
      t.references :user,            null: false, foreign_key: true
      t.integer :category_id,        null: false
      t.integer :status_id,          null: false
      t.integer :burden_id,          null: false
      t.integer :delivery_id,        null: false
      t.integer :days_delivery_id,   null: false
      t.timestamps
    end
  end
end
