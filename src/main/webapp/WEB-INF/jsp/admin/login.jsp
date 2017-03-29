<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-3-22
  Time: 下午7:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>admin login</title>
</head>
<body>
<div class="login-content"
     style="width: 400px; height: 350px;  margin-left: 150px; margin-top: 160px; padding: 10px">
    <div class="login-modal-header" style="margin-top: 30px">
        <h3 style="font-weight: normal; font-size: 26px; color: #666666;">
            管理员登录
        </h3>
    </div>
    <div>
        <form class="form-signin" action="${pageContext.request.contextPath}/admin/login.do" method="post" id="admin_login">
            <input type="text" id="aacount" class="signin-form-control" name="username"
                   placeholder="请输入管理员账号" required="" autofocus="">
            <div style="height: 30px">
            </div>
            <input type="password" id="apass" name="password"
                   class="signin-form-control" placeholder="请输入管理员密码" required="">
            <div class="form-group">
                <p style="color: red; font-size: 14px;">&nbsp;${error}</p>
            </div>
            <div class="checkbox">
                <label  style="font-weight: normal; font-size: 14px; color: #666666;">
                    <input type="checkbox" value="remember-me" >
                    记住密码
                </label>
            </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit">
                登录
            </button>
        </form>
    </div>
</div>
</body>
</html>
