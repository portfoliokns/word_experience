class CreateWordPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :word_points do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :point, null: false
      t.timestamps
    end
  end
end
