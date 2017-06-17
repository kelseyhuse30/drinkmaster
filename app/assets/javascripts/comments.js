function commentListeners(){
	$("#addComment").on("click", function(){
		var cocktailId = $(this).data("id");
		postComment(cocktailId);
	})

	$("#comments").on("click", function(){
		var id = $(this).data("id");
		getComments(id);
	});
}

function Comment(email, comment) {
    this.email = email
    this.comment = comment
 }

Comment.prototype.listComment = function() {
  return ('<li><strong>' + this.email + '</strong> said: ' + this.comment + '</li>');
}

function clearComments(){
	$("#commentUl").empty();
}

function postComment(cocktailId) {
	var commentText = $("#commentText").val()
	var userId = $("#commentText").data("user")

	$.ajax({
		method: 'post',
		url: '/cocktails/' + cocktailId + '/comments',
		data: { comment: {comment: commentText, user_id: userId, cocktail_id: cocktailId} }
		})
		.done(function(resp){
			var newComment = new Comment(resp["comment"]["user"]["email"], resp["comment"]["comment"])
			$("#commentUl").append(newComment.listComment());
			$("#commentText").val("");
		})
}

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
	var list = $("#commentUl")
	if (comments.length > 0){
	clearComments();
		comments.forEach(function(comment){
			var newComment = new Comment(comment["user"]["email"], comment["comment"])
			list.append(newComment.listComment());
		})
	} else {
		list.append('There are no comments on this cocktail yet.  Feel free to add one!')
	}
};