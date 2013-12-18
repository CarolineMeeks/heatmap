class AddBooleanToHighlights < ActiveRecord::Migration
  def change
    add_column :highlights, :highlighted, :boolean
    add_column :highlights, :session_id, :string
  end
end
