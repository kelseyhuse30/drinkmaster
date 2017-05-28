class CreateCocktailIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :cocktail_ingredients do |t|
      t.references :cocktail, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.string :quantity

      t.timestamps
    end
  end
end
