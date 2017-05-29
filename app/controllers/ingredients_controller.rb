class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]

  # GET /ingredients
  # GET /ingredients.json
  def index
    if params[:cocktail_id]
      @ingredients = Cocktail.find(params[:cocktail_id]).ingredients
    else
      @ingredients = Ingredient.all
    end
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show
  end

  # GET /ingredients/new
  def new
    if params[:cocktail_id]
      @cocktail = Cocktail.find(params[:cocktail_id])
      @cocktail_ingredient = @cocktail.cocktail_ingredients.build
      @ingredient = @cocktail_ingredient.build_ingredient
    else
      @ingredient = Ingredient.new
    end
  end

  # GET /ingredients/1/edit
  def edit
  end

  # POST /ingredients
  # POST /ingredients.json
  def create
    if ingredient_params[:cocktail_id]
      @cocktail = Cocktail.find(ingredient_params[:cocktail_id])
      @ingredient = Ingredient.find_or_create_by(name: ingredient_params[:name])
      @cocktail.cocktail_ingredients.build(:ingredient_id => @ingredient.id, :quantity => ingredient_params[:cocktail_ingredient][:quantity])
      if @cocktail.save!
        redirect_to cocktail_path(@cocktail)
      else
      redirect_to new_cocktail_ingredient_path(@cocktail)
      end
    else
      @ingredient = Ingredient.create(ingredient_params)
      if @ingredient.save
        redirect_to ingredients_path
      else
        render 'new'
      end
    end
  end

  # PATCH/PUT /ingredients/1
  # PATCH/PUT /ingredients/1.json
  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        format.html { render :edit }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to ingredients_url, notice: 'Ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_params
      params.require(:ingredient).permit(:name, :cocktail_id, cocktail_ingredient: [:quantity])
    end
end
