class CreateDrinksNew < ActiveRecord::Migration[6.1]
  def change
    create_table :drinks do |t|
      t.integer :drinks_db_id
    end
  end
end
