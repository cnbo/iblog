var pages = 1, page = 1, keyword = '', users;
var keywordIsEmpty = true;

$(function() {
	getUsers();
	
	$('.toggle-modal').click(function() {
		var modalId = $(this).attr('modal');
		toggleModal(modalId);
	});
});

function getUsers() {
	keyword = $('#search-key').val();
	if (keywordIsEmpty && keyword !== '') {
		page = 1;
		keywordIsEmpty = false;
	} else if (!keywordIsEmpty && keyword === '') {
		page = 1;
		keywordIsEmpty = true;
	}
	$.ajax({
		type: "POST",
		url: "userManage.do",
		data: {"action":"getUserList", "keyword":keyword, "page":page},
		success: function(msg) {
			refresh(msg);
		},
		error: function(msg) {
			alert('服務器訪問失敗!');
		}
	});
}

function refresh(msg) {
	var data = JSON.parse(msg);
	users = data.users;
//	var userListHtml = genUserListHtml(users);
//	$('#user-list').html(userListHtml);
	genUserList(users);
	pages = data.pages;
	page = data.page;
	var pageHtml = genPageHtml();
	$('#do-page').html(pageHtml);
	$('#page-' + page).css('color', 'blue');
	setPageEvent();
}

function genUserList(users) {	
	for (var i = 0; i < users.length; i++) {
		var user = users[i];
		var templateTr = $('.template-tr').clone();
		templateTr.removeClass('template-tr');
		var trId = 'tr' + user.id;
		templateTr.attr('id', trId);
		templateTr.css('display', 'inline-flexbox');
		$('#' + trId + '>.user-id').text(user.id);
		$('#' + trId + '>.user-name').text(user.username);
		$('#' + trId + '>.user-sal').text(user.sal);
		$('#' + trId + '>.user-dpt').text(user.dpt);
		$('#' + trId + ', .update-user').attr('user-index', i);
		$('#' + trId + ', .delete-user').attr('user-id', user.id);	
		$('#user-list-body').append(templateTr);
	}
	
	$('.update-user').click(function() {
		var userId = $(this).attr('user-index');
		updateUser(userId);
	});
	
	$('.delete-user').click(function() {
		var userId = $(this).attr('user-id');
		deleteUser(userId);
	});
}

function setPageEvent() {
	$('.page').click(function() {
		var text = $(this).text();
		switch (text) {
		case "上一頁":
			page = page - 1;
			break;
		case "最後一頁":
			page = pages;
			break;
		case "下一頁":
			page = page + 1;
			break;
			default:
				page = text;
			break;
		}
		getUsers();
	});

}

function search() {
	getUsers();
}

function deleteUser(id) {
	$.ajax({
		type: "POST",
		url: "userManage.do",
		data: {"action":"deleteUser", "id":id},
		success: function(msg) {
			var data = JSON.parse(msg);
			if (data.deleteResult === true) {
				alert('刪除成功');
				getUsers();
			} else {
				alert('刪除失敗');
			}
		},
		error: function(msg) {
			alert('服務器訪問失敗!');
		}
	});
}

function genPageHtml() {
	var pageHtml = "<ul>";
	if (page > 1) {
		pageHtml += "<li><span id='page-0' class='page'>上一頁</span></li>";
	}
	
	var pageNo = page;
	var count = 1;
	while (count < 5) {
		if (pageNo > pages) {
			break;
		}
		pageHtml += "<li><span id='page-" + pageNo + "' class='page'>" + pageNo + "</span></li>";
		pageNo++;
		count++;
	}
	
	if (pageNo < pages - 1) {
		pageHtml += "<li><span>...</span></li>";
	}
	
	if (page < pages) {
		pageHtml += "<li><span id='page-6' class='page'>最後一頁</span></li>";
		pageHtml += "<li><span id='page-7' class='page'>下一頁</span></li>";
	}
	pageHtml += "</ul>";
	
	return pageHtml;
}


function genUserListHtml(users) {
	var table = "<table>";
	table += "<thead>";
	table += "<tr>";
	table += "<th>id</th>";
	table += "<th>username</th>";
	table += "<th>sal</th>";
	table += "<th>dpt</th>";
	table += "<th>操作</th>";
	table += "</tr>";
	table += "</thead>";

	table += "<tbody>";
	for (var i = 0; i < users.length; i++) {
		var user = users[i];
		table += "<tr>";
		table += "<td>" + user.id + "</td>";
		table += "<td>" + user.username + "</td>";
		table += "<td>" + user.sal + "</td>";
		table += "<td>" + user.dpt + "</td>";
		table += "<td>";
		table += "<input type='button' value='修改' class='toggle-modal' modal='update-modal' onclick='updateUser(" + i + ")'>";
		table += "<input type='button' value='刪除' onclick='deleteUser(" + user.id + ")'>";
		table += "</tr>";
	}
	table += "<tbody>";
	table += "</table>";

	return table;
}

function submitAddUser() {
	$.ajax({
		type: "POST",
		url: "userManage.do",		 	
		data: {"action":"addUser", "username":$('#username').val(), "pwd":$('#pwd').val(),
				"sal":$('#sal').val(), "dpt":$('#dpt').val()},
		success: function(msg){
			var data = JSON.parse(msg);
			if (data.saveResult === true) {
				alert('添加成功');
				getUsers();
			} else {
				alert('添加失敗');
			}
		},
		error: function(msg){
			alert('服務器訪問失敗');
		}
	});
	openCancelAddModal();
}

function submitUpdateUser() {
	$.ajax({
		type: "POST",
		url: "userManage.do",		 	
		data: {"action":"updateUser", "id":$('#id').val(), "username":$('#name').val(), "pwd":$('#password').val(),
				"sal":$('#sala').val(), "dpt":$('#depart').val()},
		success: function(msg){
			var data = JSON.parse(msg);
			if (data.updateResult === true) {
				alert('修改成功');
				getUsers();
			} else {
				alert('修改失敗');
			}
		},
		error: function(msg){
			alert('服務器訪問失敗');
		}
	});
	openCancelUpdateModal();
}

function updateUser(i) {
	toggleModal('update-modal');
	$('#id').val(users[i].id);
	$('#name').val(users[i].username);
	$('#password').val(users[i].pwd);
	$('#sala').val(users[i].sal);
	$('#depart').val(users[i].dpt);
}

function toggleModal(id) {
	var modal = $('#' + id);
	if (modal.css('visibility') === 'hidden') {
		modal.css('visibility', 'visible');
	} else {
		modal.css('visibility', 'hidden');
	}
}
