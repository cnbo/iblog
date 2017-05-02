<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-3-29
  Time: 下午7:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>category</title>
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.css">
</head>
<body>
<a href="${pageContext.request.contextPath}/index.do">${requestScope.admin.nickname}</a>

<a href="${pageContext.request.contextPath}/index.do">HOME</a>
<a href="${pageContext.request.contextPath}/author/resume.do">ABOUT</a>

<a href="#">LOGIN</a>
<a href="#">REGISTER</a>

<div>
    My Blog Categories
</div>

<div>
    <c:forEach items="${requestScope.categoriesAndBlogs}" var="categoryAndBlogs">
        <h4>${categoryAndBlogs.category.categoryName}</h4>
        <div>
            <c:forEach items="${categoryAndBlogs.blogs}" var="blog">
                <a href="${pageContext.request.contextPath}/blog/${blog.id}.do" target="_blank">${blog.title}</a><br>
            </c:forEach>
        </div>
    </c:forEach>
</div>



<!-- footer -->
<div class="footer-class">
    <a href="${requestScope.admin.github}">这里放一个github图标</a>
    <a href="mailto:${requestScope.admin.email}">这里放一个邮箱图标</a>

    &copy2017 by iblog developer
</div>

<script src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>
<script src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>
</body>
</html>
