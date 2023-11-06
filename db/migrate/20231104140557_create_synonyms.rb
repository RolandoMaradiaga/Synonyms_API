class CreateSynonyms < ActiveRecord::Migration[6.0]
  def change
    create_table :synonyms do |t|
      t.string :text
      t.references :word, null: false, foreign_key: true
      t.boolean :approved

      t.timestamps
    end
  end
end
