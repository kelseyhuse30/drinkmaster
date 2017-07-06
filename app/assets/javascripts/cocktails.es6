function cocktailListeners(){
	$("#next").on("click", function(){
		clearComments();
		var id = $(this).data("id");
		getCocktail(id);
	})
};

function getCocktail(id) {
	$.ajax({
		method: 'get',
		url: '/cocktails/' + id,
		dataType: 'json'
	})
	.done(function(resp) {
		populateFields(resp["cocktail"]);
	})
}

function populateFields(cocktail){
	$("#name").text(cocktail["name"]);
	renderAlcoholic(cocktail["alcoholic"])
	$("#email").text(cocktail["user"]["email"]);
	$("#instructions").text(cocktail["instructions"]);
	populateIngredients(cocktail["cocktail_ingredients"]);
	$("#edit").attr("href", `/cocktails/${cocktail["id"]}/edit`);
	$("#next").data("id", `${cocktail["id"] + 1}`);
	$(".comments").data("id", `${cocktail["id"]}`);
}

function renderAlcoholic(bool) {
	var result = bool ? "Alcoholic Beverage" : "Non-alcoholic"
	$("#alcoholic").text(result);
}

function populateIngredients(ingredients) {
	var list = $("#ingredientsList");
	list.empty();
	if (ingredients.length > 0){
		ingredients.forEach(function(cocktail_ingredient){
			list.append(`<li> ${cocktail_ingredient["quantity"]} of ${cocktail_ingredient["ingredient"]["name"]} </li>`)
			});
		}
}