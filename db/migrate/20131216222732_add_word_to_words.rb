class AddWordToWords < ActiveRecord::Migration
  def change
    add_column :words, :word, :string
  end
end
