<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-3-25
  Time: 下午3:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>admin profile</title>
    <link type="text/css" rel="stylesheet"
        href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.css">
    <link type="text/css" media="all" rel="stylesheet"
        href="${pageContext.request.contextPath}/lib/bootstrap-fileinput/css/fileinput.css">
    <link type="text/css" media="all" rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/editor-md/css/editormd.css">

    <style>
        .kv-avatar .file-preview-frame,.kv-avatar .file-preview-frame:hover {
            margin: 0;
            padding: 0;
            border: none;
            box-shadow: none;
            text-align: center;
        }
        .kv-avatar .file-input {
            display: table-cell;
            max-width: 220px;
        }
    </style>
</head>
<body>
    <h2>个人信息</h2>
    <form id="profile-form" enctype="multipart/form-data">
        昵称 <input type="text" name="nickname" id="nickname">    <br>
        邮箱 <input type="email" name="email" id="email">         <br>
        GitHub <input type="url" name="github" id="github">       <br>
        座右铭 <input type="text" name="inroduction" id="inroduction"> <br>
        <div class="kv-avatar center-block" style="width:200px">
            头像 <input type="file" id="avatar-file" name="file" class="file-loading"> <br>
        </div>
        <%--头像 <input type="file" name="file">--%>
        <input type="submit" title="保存">
    </form>

    <h2>修改密码</h2>
    <form id="modify-password-form">
        旧密码 <input type="password" name="oldPassword" id="old-password"> <br>
        新密码 <input type="password" name="newPassword" id="new-password"> <br>
        确认密码 <input type="password" id="confrim-password"> <br>
        <input type="submit" title="保存">
    </form>

    <h2>个人简历</h2>
    <button id="save-resume-btn" onclick="saveResume()">保存</button>
    <div id="resume-editormd">
            <textarea name="resumeMd">

            </textarea>

    </div>

    <table>
        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/admin/blog/write.do">写博客</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/admin/blog/manage.do">博客管理</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/admin/category/manage.do">标签/分类</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/admin/friendly-link/manage.do">友情链接</a>
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

    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/canvas-to-blob.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/sortable.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/purify.js    "></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/fileinput.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/zh.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/editor-md/js/editormd.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/js/profile.js"></script>
</body>
</html>
