class CreateParagraphs < ActiveRecord::Migration[7.0]
  def change
    create_table :paragraphs do |t|
      t.text :content
      t.integer :level, default: 1
      t.integer :score, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :story, null: false, foreign_key: true
      t.references :previous_paragraph, foreign_key: { to_table: :paragraphs }

      t.timestamps
    end
  end
end
