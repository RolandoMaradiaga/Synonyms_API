class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :text

      t.timestamps
    end
    add_index :words, :text, unique: true
  end
end
