class CreateStorages < ActiveRecord::Migration
  def change
    create_table :storages do |t|
      t.references :user, index: true, foreign_key: true
      t.references :letter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
