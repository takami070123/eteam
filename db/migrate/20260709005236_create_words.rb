class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :word, null: false

      t.timestamps
    end

    add_index :words, :word, unique: true
  end
end
