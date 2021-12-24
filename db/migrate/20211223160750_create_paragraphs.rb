class CreateParagraphs < ActiveRecord::Migration[7.0]
  def change
    create_table :paragraphs do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :story, foreign_key: true
      t.references :previous, foreign_key: { to_table: :paragraphs }

      t.timestamps
    end
  end
end
