<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-4-1
  Time: 下午4:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>write blog</title>
    <%--Bootstrap css--%>
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.css">
    <%--bootstrap-fileinput css--%>
    <link type="text/css" media="all" rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/bootstrap-fileinput/css/fileinput.css">
    <link type="text/css" media="all" rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/editor-md/css/editormd.css">

</head>
<body>
    <c:if test="${requestScope.blog != null}">
        <input type="hidden" id="edit-id" value="${requestScope.blog.id}">
    </c:if>
    <input type="text" name="title" id="title" required="true" value="无标题文章"> <br>
    <select id="category-select">
        <c:if test="${ empty requestScope.blogCategories}">
            <option value="">java</option>
        </c:if>
        <c:if test="${requestScope.blogCategories != null && requestScope.blog != null}">
            <c:forEach items="${requestScope.blogCategories}" var="category">
                <c:if test="${category.id == requestScope.blog.categoryId}">
                    <option value="${category.id}" selected="selected">${category.categoryName}</option>
                </c:if>
                <c:if test="${category.id != requestScope.blog.categoryId}">
                    <option value="${category.id}">${category.categoryName}</option>
                </c:if>
            </c:forEach>
        </c:if>
        <c:if test="${requestScope.blogCategories != null && requestScope.blog == null}">
            <c:forEach items="${requestScope.blogCategories}" var="category">
                 <option value="${category.id}">${category.categoryName}</option>
            </c:forEach>
        </c:if>
    </select> <br>
    <button id="save-btn" onclick="saveOrUpdateBlog()">保存</button>
    <button id="publish-btn" onclick="updateStatus(1)">发布</button>
    <button id="draft-btn" onclick="updateStatus(1)">存为草稿</button>


    <h3>blog</h3>
    <div id="blog-editor">

        <textarea>
            <c:if test="${requestScope.blog != null}">
${requestScope.blog.blogMd}
            </c:if>
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
            src="${pageContext.request.contextPath}/js/blog-write.js"></script>
</body>
</html>
