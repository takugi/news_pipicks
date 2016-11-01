class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title, null: false
      t.string :image, null: false, default: ""
      t.string :url, null: false, default: ""
      t.string :author, null: false, default: ""
      t.string :manufacturer, null: false, default: ""

      t.timestamps null: false
    end
  end
end
