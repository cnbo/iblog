<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <title>user manage</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="${ pageContext.request.contextPath }/js/jquery.js"></script>
    <script src="${ pageContext.request.contextPath }/user/user-manage.js"></script>
    
    <style>
    ul {
    	display: inline;
    }
    
    li {
    	float: left;
    	list-style-type: none;
    	padding: 10px 7px;
    	
    }

	.template-tr {
		display: none;
	}

	.my-modal {
		visibility: hidden;
		position: absolute;
		left: 0px;
		top: 0px;
		width: 100%;
		height: 100%;
		text-align: center;
		z-index: 1000;
		background-color: #333;
		opacity: 0.5; 
	}

	.modal-data {
		width: 300px;
		margin: 100px auto;
		background-color: #fff;
		border: 1px solid #000;
		padding: 15px;
		text-align: center;
	}
	
    </style>
  </head>
  <body>
  	<div>
  		<input type="text" id="search-key" placeholder="請輸入用戶名">
  		<input type="button" onclick="search()" value="搜索">
  	</div>
  	<div>
  		<input type="button" class="toggle-modal" modal='add-modal' value="新增">
  	</div>
  	<div id="user-list">
  		<table>
  			<thead>
	  			<tr>
	  				<th>id</th>
	  				<th>username</th>
	  				<th>sal</th>
	  				<th>dpt</th>
	  				<th>操作</th>
	  			</tr>
	  		</thead>
	  		<tbody id="user-list-body">
	  			<tr class="template-tr">
			  		<td class="user-id"></td>
			  		<td class="user-name"></td>
			  		<td class="user-sal"></td>
			  		<td class="user-dpt"></td>
			  		<td>
			  			<input type='button' value='修改' class="update-user">
			  			<input type='button' value='刪除' class="delete-user">
			  		</td>
			  	</tr>
	  		</tbody>
  		</table>
  	</div>
  	<div id="do-page"></div>
  	
  	<div id="add-modal" class="my-modal">
  		<div class="modal-data">
  			<h2>添加用戶</h2>
  			<form id="add-form">
  				<div>
  					用戶名  <input type="text" id="username" placeholder="請輸入用戶名" required="required">
  				</div>
  				<div>
  					密碼 <input type="password" id="pwd" placeholder="請輸入密碼" required="required">
  				</div>
  				<div>
  					工資 <input type="text" id="sal" placeholder="請輸入工資" required="required">
  				</div>
  				<div>
  					部門<input type="text" id="dpt" placeholder="請輸入部門代碼" required="required">
  				</div>
  				<div>
  					<input type="button" value="確定" onclick="submitAddUser()">
  					<input type="button" value="取消" class="toggle-modal" modal='add-modal'>
  				</div>
  			</form>
  		</div>
  	</div>
  	
  	<div id="update-modal" class="my-modal">
  		<div class="modal-data">
  			<h2>修改用戶</h2>
  			<form id="add-form">
				<input type="hidden" id="id">
  				<div>
  					用戶名  <input type="text" id="name">
  				</div>
  				<div>
  					密碼 <input type="password" id="password">
  				</div>
  				<div>
  					工資 <input type="text" id="sala">
  				</div>
  				<div>
  					部門<input type="text" id="depart">
  				</div>
  				<div>
  					<input type="button" value="確定" onclick="submitUpdateUser()">
  					<input type="button" value="取消" class="toggle-modal" modal='update-modal'>
  				</div>
  			</form>
  		</div>
  	</div>
  </body>
</html>
