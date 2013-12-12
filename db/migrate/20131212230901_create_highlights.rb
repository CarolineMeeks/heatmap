class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.references :word, index: true
      t.string :nym

      t.timestamps
    end
  end
end
