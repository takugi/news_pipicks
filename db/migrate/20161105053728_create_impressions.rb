class CreateImpressions < ActiveRecord::Migration
  def change
    create_table :impressions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
