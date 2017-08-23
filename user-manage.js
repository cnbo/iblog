var users = [{id: 10, name: "z"}, {id: 11, name: "h"}, {id: 12, name: "gg"}, {id: 13, name: "engi"}]
var genUserList = function(users) {
  for(var i = 0; i <  users.length; i++) {
    var user = users[i];
    var templateTr = $('.template-tr').clone();
		var trId = 'tr' + user.id;
		templateTr.attr('id', trId);
		templateTr.css('display', 'block');
    templateTr.removeClass("template-tr");
    templateTr.appendTo("#user-list-body");
		$('#' + trId + '> .user-id').text(user.id);
		$('#' + trId + '> .user-name').text(user.name);
  }
}

genUserList(users)
