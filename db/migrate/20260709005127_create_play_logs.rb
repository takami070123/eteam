class CreatePlayLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :play_logs do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade, on_update: :cascade }
      t.integer :score, null: false
      t.integer :correct_count, null: false
      t.integer :miss_count, null: false

      t.timestamps
    end
  end
end
