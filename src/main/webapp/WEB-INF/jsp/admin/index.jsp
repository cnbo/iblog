<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-3-25
  Time: 下午2:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title>admin index</title>
</head>
<body>
    <table>
        <tr>
            <td>
                <a href="#">发布文章</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="#">文章管理</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="#">标签/分类</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="#">友情链接</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="#">用户管理</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="#">评论管理</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/admin/profile.do">个人信息</a>
            </td>
        </tr>
    </table>
</body>
</html>
