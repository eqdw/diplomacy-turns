class AddNationDataToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string  :nation
      t.boolean :alive
    end
  end
end
