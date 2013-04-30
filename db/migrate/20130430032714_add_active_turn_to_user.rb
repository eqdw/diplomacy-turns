class AddActiveTurnToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :turn
    end
  end
end
