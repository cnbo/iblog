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
  <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.css">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hux-blog.min.css">
  <link href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <%--<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.css">--%>
</head>

<nav class="navbar navbar-default navbar-custom navbar-fixed-top">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header page-scroll">
      <button type="button" class="navbar-toggle">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="${pageContext.request.contextPath}/index.do">IBLOG</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div id="huxblog_navbar">
      <div class="navbar-collapse">
        <ul class="nav navbar-nav navbar-right">


          <li>
            <a href="${pageContext.request.contextPath}/index.do">${requestScope.admin.nickname}</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/index.do">HOME</a>
          </li>

          <li>
            <a href="${pageContext.request.contextPath}/about.do">ABOUT</a>
          </li>

          <li>
            <a href="${pageContext.request.contextPath}/category.do">CATEGORY</a>
          </li>


          <%--<li>--%>
          <%--<a href="/portfolio/">Portfolio</a>--%>
          <%--</li>--%>

         <c:choose>
            <c:when test="${sessionScope.visitorName == null}">
              <li>
                <a href="#" data-toggle="modal" data-target="#loginModal">LOGIN</a>
              </li>
              <li>
                <a href="#" data-toggle="modal" data-target="#registModal">REGISTER</a>
              </li>
            </c:when>
            <c:otherwise>
              ${sessionScope.visitorName}
              <li>
                <a href="javascript:void(0);" onclick="logout()">LOGOUT</a>
              </li>
            </c:otherwise>
          </c:choose>

        </ul>
      </div>
    </div>
    <!-- /.navbar-collapse -->
  </div>
  <!-- /.container -->
</nav>


<!-- Page Header -->
<header class="intro-header" style="background-image: url('${pageContext.request.contextPath}/uploads/home-bg.jpg'); ">

  <div class="container">
    <div class="row">
      <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 ">
        <div class="site-heading">
          <h1>${requestScope.admin.nickname}</h1>
          <!--<hr class="small">-->
          <span class="subheading">
            ${requestScope.admin.introduction}
          </span>
        </div>
      </div>
    </div>
  </div>

</header>



<div class="container">
  <div class="row">


    <!-- USE SIDEBAR -->
    <!-- PostList Container -->
    <div class="col-lg-8 col-lg-offset-1
                col-md-8 col-md-offset-1
                col-sm-12
                col-xs-12
                postlist-container
            ">
      <c:if test="${requestScope.blogs != null}">
        <c:forEach items="${requestScope.blogs}" var="blog">

          <div class="post-preview">
            <a href="blog/${blog.id}.do" target="_blank">
              <h2 class="post-title">
                  ${blog.title}
              </h2>

                <%--<h3 class="post-subtitle">--%>
                <%--The Next Generation Application Model For The Web - Progressive Web App--%>
                <%--</h3>--%>

              <div class="post-content-preview">
                  ${blog.blogHtml}
              </div>
            </a>
            <p class="post-meta">
              发表于
              <fmt:formatDate value="${blog.publishTime}" pattern="yyyy-MM-dd HH:mm" /> 浏览 ${blog.readTimes} 评论 ${blog.commentTimes}
            </p>
          </div>
        </c:forEach>
      </c:if>


      <div>
        <ul class="pager">
            <c:choose>
              <c:when test="${requestScope.page == 1 and requestScope.pages > requestScope.page}">
              <li class="next">
                <a href="index.do?page=${requestScope.page + 1}">下一页</a>
              </li>
              </c:when>
              <c:otherwise>
                <c:if test="${requestScope.page > 1}">
                  <li class="previous">
                    <a href="index.do?page=${requestScope.page - 1}">上一页</a>
                  </li>
                </c:if>
                <c:if test="${requestScope.page != requestScope.pages}">
                  <li class="next">
                    <a href="index.do?page=${requestScope.page + 1}">下一页</a>
                  </li>
                </c:if>
              </c:otherwise>
            </c:choose>
        </ul>
      </div>

    </div>


    <div class="
                col-lg-3 col-lg-offset-0
                col-md-3 col-md-offset-0
                col-sm-12
                col-xs-12
                sidebar-container
            ">
      <!-- Featured Tags -->
      <section>
        <hr/><h5><a href="/tags/">TOP BLOG</a></h5>
        <c:if test="${requestScope.topBlogs != null}">
          <c:forEach items="${requestScope.topBlogs}" var="blog">
            <a href="blog/${blog.id}.do">${blog.title}</a><br/>
          </c:forEach>
        </c:if>

      </section>

      <section>
        <hr/><h5><a href="/tags/">NEW BLOG</a></h5>
        <c:if test="${requestScope.recentBlogs != null}">
          <c:forEach items="${requestScope.recentBlogs}" var="blog">
            <a href="blog/${blog.id}.do">${blog.title}</a><br/>
          </c:forEach>
        </c:if>
      </section>

      <hr>
      <h5>FRIENDS</h5>
      <ul class="list-inline">
        <!-- 友情链接 -->
          <c:if test="${requestScope.friendlyLinks != null}">
            <c:forEach items="${requestScope.friendlyLinks}" var="friendlyLink">
              <a href="${friendlyLink.url}" target="_blank">${friendlyLink.friendName}</a>
            </c:forEach>
          </c:if>


      </ul>

    </div>

  </div>
</div>

<span style="padding: 10px; border: 1px solid greenyellow"><i class="fa fa-angle-up" aria-hidden="true"></i></span>

<!-- footer -->
<%@include file="footer.jsp"%>


<%@include file="regist.jsp"%>
<%@include file="login.jsp"%>

<script type="application/javascript" src="${pageContext.request.contextPath}/lib/js/jquery-1.12.4.js"></script>
<script type="application/javascript" src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>
<%@include file="../common/visitor-js.jsp"%>
</body>
</html>