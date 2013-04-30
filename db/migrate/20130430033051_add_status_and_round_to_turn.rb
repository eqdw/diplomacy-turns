class AddStatusAndRoundToTurn < ActiveRecord::Migration
  def change
    change_table :turns do |t|
      t.integer :round
      t.boolean :active, :default => true
    end
  end
end
