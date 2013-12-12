class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.references :passage, index: true
      t.integer :index

      t.timestamps
    end
  end
end
