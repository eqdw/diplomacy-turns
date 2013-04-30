class RemoveUserActiveTurnFk < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.remove_references :turn
    end
  end

  def down
    t.references :turn
  end
end
