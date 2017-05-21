class CreateCocktails < ActiveRecord::Migration[5.0]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.integer :creator_id
      t.string :glass
      t.text :instructions
      t.boolean :custom

      t.timestamps
    end
  end
end
