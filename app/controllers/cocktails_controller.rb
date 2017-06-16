class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :update, :destroy]

  # GET /cocktails
  # GET /cocktails.json
  def index
    if params[:user_id]
      @cocktails = User.find(params[:user_id]).cocktails
    else
      @cocktails = Cocktail.all
    end
  end

  def mocktails
    @cocktails = Cocktail.mocktails
    render 'index'
  end

  def ordered
    @cocktails = Cocktail.order_by_ingredients
    render 'index'
  end

  # GET /cocktails/1
  # GET /cocktails/1.json
  def show

  end

  # GET /cocktails/new
  def new
    @cocktail = Cocktail.new
    5.times { @cocktail.cocktail_ingredients.build.build_ingredient }
  end
  # GET /cocktails/1/edit
  def edit
  end

  # POST /cocktails
  # POST /cocktails.json
  def create
    @cocktail = current_user.cocktails.build(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      5.times { @cocktail.cocktail_ingredients.build.build_ingredient }
      render 'new'
    end
  end

  # PATCH/PUT /cocktails/1
  # PATCH/PUT /cocktails/1.json
  def update
    respond_to do |format|
      if @cocktail.update(cocktail_params)
        format.html { redirect_to @cocktail, notice: 'Cocktail was successfully updated.' }
        format.json { render :show, status: :ok, location: @cocktail }
      else
        format.html { render :edit }
        format.json { render json: @cocktail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cocktails/1
  # DELETE /cocktails/1.json
  def destroy
    @cocktail.destroy
    respond_to do |format|
      format.html { redirect_to cocktails_url, notice: 'Cocktail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def require_login
      if !user_signed_in?  
        flash[:alert] = "Must be logged in" 
        redirect_to root_path
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_cocktail
      @cocktail = Cocktail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cocktail_params
      params.require(:cocktail).permit(:name, :instructions, :alcoholic,
       cocktail_ingredients_attributes: [:quantity,
       ingredient_attributes: [:name]])
    end
end
