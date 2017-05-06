<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-3-29
  Time: 下午7:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title>iblog developer</title>
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.css">


</head>
<body>
<a href="${pageContext.request.contextPath}/index.do">${requestScope.admin.nickname}</a>

<a href="${pageContext.request.contextPath}/index.do">HOME</a>
<a href="${pageContext.request.contextPath}/author/resume.do">ABOUT</a>

<c:choose>
    <c:when test="${sessionScope.visitorName == null}">
        <a href="#" data-toggle="modal" data-target="#loginModal">LOGIN</a>
        <a href="#" data-toggle="modal" data-target="#registModal">REGISTER</a>
    </c:when>
    <c:otherwise>
        ${sessionScope.visitorName}
        <a href="javascript:void(0);" onclick="logout()">LOGOUT</a>
     </c:otherwise>
</c:choose>




<div>
    ${requestScope.admin.introduction}
</div>


<div id="layout">
    <c:if test="${requestScope.blogs != null}">
        <c:forEach items="${requestScope.blogs}" var="blog">
            <div>
                <a href="blog/${blog.id}.do" target="_blank">${blog.title}</a>

            </div>
            <div style="width: 40%;">
                    ${blog.blogHtml}
            </div>
            <div>
                发表于<fmt:formatDate value="${blog.publishTime}"  dateStyle="long"/>
                浏览 ${blog.readTimes}
                评论 ${blog.commentTimes}
                喜欢 ${blog.loveTimes}
            </div>
        </c:forEach>
    </c:if>
</div>


<div>
    <c:choose>
        <c:when test="${requestScope.page == 1 and requestScope.pages > requestScope.page}">
            <a href="index.do?page=${requestScope.page + 1}">下一页</a>
        </c:when>
        <c:otherwise>
            <a href="index.do?page=${requestScope.page - 1}">上一页</a>
            <c:if test="${requestScope.page != requestScope.pages}">
                <a href="index.do?page=${requestScope.page + 1}">下一页</a>
            </c:if>
        </c:otherwise>
    </c:choose>
</div>

<div>
    <!-- 排行榜 -->
    <div>
        <h4>TOP BLOG</h4>
        <c:if test="${requestScope.topBlogs != null}">
            <c:forEach items="${requestScope.topBlogs}" var="blog">
                <a href="${blog.id}">${blog.title}</a>
            </c:forEach>
        </c:if>
    </div>
</div>
<div>
    <h4>NEW BLOG</h4>
    <!-- 最新文章 -->
    <div>
        <c:if test="${requestScope.recentBlogs != null}">
            <c:forEach items="${requestScope.recentBlogs}" var="blog">
                <a href="${blog.id}">${blog.title}</a>
            </c:forEach>
        </c:if>
    </div>
</div>


<!-- 友情链接 -->
<div id="friend-link-div">
    <h4>FRIENDLY LINK</h4>
    <c:if test="${requestScope.friendlyLinks != null}">
        <c:forEach items="${requestScope.friendlyLinks}" var="friendlyLink">
            <a href="${friendlyLink.url}" target="_blank">${friendlyLink.friendName}</a>
        </c:forEach>
    </c:if>
</div>

<!-- footer -->
<div class="footer-class">
    <a href="${requestScope.admin.github}">这里放一个github图标</a>
    <a href="mailto:${requestScope.admin.email}">这里放一个邮箱图标</a>

    &copy2017 by iblog developer
</div>

<%@include file="regist.jsp"%>
<%@include file="login.jsp"%>

<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/js/regist.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/js/login.js"></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/js/logout.js"></script>
</body>
</html>
