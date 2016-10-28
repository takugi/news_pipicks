class ChangeColumnsToLetters < ActiveRecord::Migration
  def up
    change_column :letters, :title, :string, null: false, default: ""
    change_column :letters, :image, :string, null: false, default: ""
    change_column :letters, :site_name, :string, null: false, default: ""
    change_column :letters, :description, :text, null: true
    change_column :letters, :category, :string, null: false, default: ""
    change_column :letters, :confidence, :real, null: false, default: 0
  end
  def down
    change_column :letters, :title, :string
    change_column :letters, :image, :string
    change_column :letters, :site_name, :string
    change_column :letters, :description, :string
    change_column :letters, :category, :string
    change_column :letters, :confidence, :integer
  end
end
