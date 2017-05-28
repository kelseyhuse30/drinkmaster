class CreateCocktails < ActiveRecord::Migration[5.0]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.integer :user_id
      t.text :instructions
      t.boolean :alcoholic

      t.timestamps
    end
  end
end
