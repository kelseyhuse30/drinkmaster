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
		debugger;
	})
}