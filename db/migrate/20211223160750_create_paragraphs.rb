class CreateParagraphs < ActiveRecord::Migration[7.0]
  def change
    create_table :paragraphs do |t|
      t.integer :position
      t.text :content
      t.integer :score, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :story, null: false, foreign_key: true

      t.timestamps
    end

    add_index :paragraphs, :position, unique: true
    add_index :paragraphs, :score, unique: true
  end
end
