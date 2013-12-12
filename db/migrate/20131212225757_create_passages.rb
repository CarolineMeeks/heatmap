class CreatePassages < ActiveRecord::Migration
  def change
    create_table :passages do |t|
      t.text :prompt
      t.text :content

      t.timestamps
    end
  end
end
