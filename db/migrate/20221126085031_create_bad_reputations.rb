class CreateBadReputations < ActiveRecord::Migration[6.0]
  def change
    create_table :bad_reputations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :word, null: false, foreign_key: true
      t.references :exchanged_word, null: false, foreign_key: true
      t.boolean :bad_flag, null: false
      t.timestamps
    end
  end
end
