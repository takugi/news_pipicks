class AddColumnsToLetters < ActiveRecord::Migration
  def change
    add_column :letters, :site_name, :string
    add_column :letters, :description, :string
    add_column :letters, :url, :string
  end
end
