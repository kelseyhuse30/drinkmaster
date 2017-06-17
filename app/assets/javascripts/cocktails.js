$(function(){
	attachListeners();
});

function attachListeners(){
	$("#comments").on("click", function(){
		var id = $(this).data("id");
		getComments(id);
	});

	$("#next").on("click", function(){
		var id = $(this).data("id");
		getCocktail(id);
	})
};

function getComments(id) {
	$.ajax({
		method: 'get',
		url: '/cocktails/' + id + '/comments'
	})
	.done(function(resp) {
		populateComments(resp["comments"]);
	})
};

function populateComments(comments){
if (comments.length > 0){
	var list = $("#commentDiv").append('<ul></ul>').find('ul');
			comments.forEach(function(comment){
				list.append('<li id="' + comment["id"] + '">' + comment["comment"] + "</li>")
			})
		}
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