class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.text :orders
      t.references :user

      t.timestamps
    end
  end
end
