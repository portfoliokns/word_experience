class CreateGoodReputations < ActiveRecord::Migration[6.0]
  def change
    create_table :good_reputations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :word, null: false, foreign_key: true
      t.references :exchanged_word, null: false, foreign_key: true
      t.boolean :flag, null: false
      t.timestamps
    end
  end
end
