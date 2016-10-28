class AddConfidenceToLetters < ActiveRecord::Migration
  def change
    add_column :letters, :confidence, :integer
  end
end
