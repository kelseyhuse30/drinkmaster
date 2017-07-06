function commentListeners(){
	$("#addComment").on("click", function(){
		var cocktailId = $(this).data("id");
		postComment(cocktailId);
	});

	$("#comments").on("click", function(){
		var id = $(this).data("id");
		getComments(id);
	});

	$(".delete").on("click", function(){
		console.log("you clicked delete");
		var id = $(this).data("comment-id");
		var cocktailId = $("#addComment").data("id");
		deleteComment(cocktailId, id);
	});
}

function Comment(email, comment, id) {
    this.email = email
    this.comment = comment
    this.commentId = id
 }

Comment.prototype.listComment = function() {
  return (`
  	<li data-comment-id="${this.commentId}">
  		<strong>${this.email}</strong> said: ${this.comment}
  		<button 
  			class="delete" 
  			data-comment-id="${this.commentId}"
  		>
  			Delete Comment
  		</button>
  	</li>
  `);
}

function deleteComment(commentId) {
	var li = $(li).data("comment-id")

	CommentAPIService.deleteComment(cocktailId, commentId);
}

function clearComments(){
	$("#commentUl").empty();
}

function postComment(cocktailId) {
	var commentText = $("#commentText").val()
	var userId = $("#commentText").data("user")

	CommentAPIService.postComment(cocktailId, commentText, userId);
}

function appendCommentToDom(resp) {
	var newComment = new Comment(resp["user"]["email"], resp["comment"], resp["id"]);
	$("#commentUl").append(newComment.listComment());
	$("#commentText").val("");
}

const CommentAPIService = {
	getComments(cocktailId) {
		const request = {
			method: 'get',
			url: '/cocktails/' + cocktailId + '/comments'
		}
		return $.ajax(request).then(json => populateComments(json["comments"]))
	},

	postComment(cocktailId, commentText, userId) {
		const request = {
			method: 'post',
			url: '/cocktails/' + cocktailId + '/comments',
			data: { 
				comment: {
					comment: commentText, 
					user_id: userId, 
					cocktail_id: cocktailId
				}
			}
		}
		
		return $.ajax(request).then(json => appendCommentToDom(json["comment"]))
	},

	deleteComment(cocktailId, commentId) {
		const request = {
			method: 'delete',
			url: '/cocktails/' + cocktailId + '/comments' + commentId
		}
		return $.ajax(request).then(CommentAPIService.getComments(cocktailId))
	}
}

function getComments(id) {
	CommentAPIService.getComments(id);
};

function populateComments(comments){
	var list = $("#commentUl")
	if (comments.length > 0){
	clearComments();
		comments.forEach(function(comment){
			var newComment = new Comment(comment["user"]["email"], comment["comment"], comment["id"])
			list.append(newComment.listComment());
		})
	} else {
		list.append('There are no comments on this cocktail yet.  Feel free to add one!')
	}
};