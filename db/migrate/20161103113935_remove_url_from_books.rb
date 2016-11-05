class RemoveUrlFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :url, :string
  end
end
