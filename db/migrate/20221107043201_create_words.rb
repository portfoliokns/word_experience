class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :name,           null: false
      t.integer :main_category_id, null: false
      t.integer :service_category_id, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
