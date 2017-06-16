$(function() {
	attachListeners();
});

function attachListeners(){
	$("#comments").on("click", function(){
		debugger;
		getComments()
	})
}