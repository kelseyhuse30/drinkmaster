class CreateUsersIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :users_ingredients do |t|
      t.references :user, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.string :quantity
      t.datetime :exp_date

      t.timestamps
    end
  end
end
