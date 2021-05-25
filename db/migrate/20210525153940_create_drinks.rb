class CreateDrinks < ActiveRecord::Migration[6.1]
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :type
      t.string :glass
      t.string :instructions
      t.string :photo_url
    end
  end
end
