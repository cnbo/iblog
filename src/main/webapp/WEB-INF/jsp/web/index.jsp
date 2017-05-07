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

</head>

<body>
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
      <a class="navbar-brand" href="/">IBLOG</a>
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
            <a href="${pageContext.request.contextPath}/author/resume.do">ABOUT</a>
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
<script>
    // Drop Bootstarp low-performance Navbar
    // Use customize navbar with high-quality material design animation
    // in high-perf jank-free CSS3 implementation
    var $body = document.body;
    var $toggle = document.querySelector('.navbar-toggle');
    var $navbar = document.querySelector('#huxblog_navbar');
    var $collapse = document.querySelector('.navbar-collapse');

    var __HuxNav__ = {
        close: function() {
            $navbar.className = " ";
            // wait until animation end.
            setTimeout(function() {
                // prevent frequently toggle
                if ($navbar.className.indexOf('in') < 0) {
                    $collapse.style.height = "0px"
                }
            }, 400)
        },
        open: function() {
            $collapse.style.height = "auto"
            $navbar.className += " in";
        }
    }

    // Bind Event
    $toggle.addEventListener('click', function(e) {
        if ($navbar.className.indexOf('in') > 0) {
            __HuxNav__.close()
        } else {
            __HuxNav__.open()
        }
    })

    /**
     * Since Fastclick is used to delegate 'touchstart' globally
     * to hack 300ms delay in iOS by performing a fake 'click',
     * Using 'e.stopPropagation' to stop 'touchstart' event from
     * $toggle/$collapse will break global delegation.
     *
     * Instead, we use a 'e.target' filter to prevent handler
     * added to document close HuxNav.
     *
     * Also, we use 'click' instead of 'touchstart' as compromise
     */
    document.addEventListener('click', function(e) {
        if (e.target == $toggle) return;
        if (e.target.className == 'icon-bar') return;
        __HuxNav__.close();
    })
</script>


<!-- Page Header -->
<header class="intro-header" style="background-image: url('${pageContext.request.contextPath}/uploads/home-bg.jpg')">
  <div class="container">
    <div class="row">
      <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 ">
        <div class="site-heading">
          <h1>IBLOG</h1>
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
              <fmt:formatDate value="${blog.publishTime}" pattern="yyyy-MM-dd HH:mm" /> 浏览 ${blog.readTimes} 评论 ${blog.commentTimes} 喜欢 ${blog.loveTimes}
            </p>
          </div>
        </c:forEach>
      </c:if>


      <div>
        <ul class="pager">
          <li class="next">
            <c:choose>
              <c:when test="${requestScope.page == 1 and requestScope.pages > requestScope.page}">
                <a href="index.do?page=${requestScope.page + 1}">下一页</a>
              </c:when>
              <c:otherwise>
                <c:if test="${requestScope.page > 1}">
                  <a href="index.do?page=${requestScope.page - 1}">上一页</a>
                </c:if>
                <c:if test="${requestScope.page != requestScope.pages}">
                  <a href="index.do?page=${requestScope.page + 1}">下一页</a>
                </c:if>
              </c:otherwise>
            </c:choose>
          </li>
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

      <%--<section>--%>
        <%--<hr class="hidden-sm hidden-xs">--%>
        <%--<h5><a href="/tags/">CATEGORYS</a></h5>--%>
        <%--<div class="tags">--%>






        <%--</div>--%>
      <%--</section>--%>


      <!-- Short About -->
      <%--<section class="visible-md visible-lg">--%>
        <%--<hr><h5><a href="/about/">ABOUT ME</a></h5>--%>
        <%--<div class="short-about">--%>

          <%--<img src="/img/avatar-hux.jpg" />--%>


          <%--<p>写写代码，做做设计，<br>离开世界之前，一切都是过程</p>--%>

          <%--<!-- SNS Link -->--%>
          <%--<ul class="list-inline">--%>



            <%--<li>--%>
              <%--<a target="_blank" href="https://www.zhihu.com/people/huxpro">--%>
                                    <%--<span class="fa-stack fa-lg">--%>
                                        <%--<i class="fa fa-circle fa-stack-2x"></i>--%>
                                        <%--<i class="fa  fa-stack-1x fa-inverse">知</i>--%>
                                    <%--</span>--%>
              <%--</a>--%>
            <%--</li>--%>


            <%--<li>--%>
              <%--<a target="_blank" href="http://weibo.com/huxpro">--%>
                                    <%--<span class="fa-stack fa-lg">--%>
                                        <%--<i class="fa fa-circle fa-stack-2x"></i>--%>
                                        <%--<i class="fa fa-weibo fa-stack-1x fa-inverse"></i>--%>
                                    <%--</span>--%>
              <%--</a>--%>
            <%--</li>--%>


            <%--<li>--%>
              <%--<a target="_blank" href="https://www.facebook.com/huxpro">--%>
                                    <%--<span class="fa-stack fa-lg">--%>
                                        <%--<i class="fa fa-circle fa-stack-2x"></i>--%>
                                        <%--<i class="fa fa-facebook fa-stack-1x fa-inverse"></i>--%>
                                    <%--</span>--%>
              <%--</a>--%>
            <%--</li>--%>


            <%--<li>--%>
              <%--<a target="_blank" href="https://github.com/huxpro">--%>
                                    <%--<span class="fa-stack fa-lg">--%>
                                        <%--<i class="fa fa-circle fa-stack-2x"></i>--%>
                                        <%--<i class="fa fa-github fa-stack-1x fa-inverse"></i>--%>
                                    <%--</span>--%>
              <%--</a>--%>
            <%--</li>--%>


          <%--</ul>--%>
        <%--</div>--%>
      <%--</section>--%>
      <!-- Friends Blog -->

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




<%--<div>--%>
  <%--<!-- 排行榜 -->--%>
  <%--<div>--%>
    <%--<h4>TOP BLOG</h4>--%>
    <%--<c:if test="${requestScope.topBlogs != null}">--%>
      <%--<c:forEach items="${requestScope.topBlogs}" var="blog">--%>
        <%--<a href="${blog.id}">${blog.title}</a>--%>
      <%--</c:forEach>--%>
    <%--</c:if>--%>
  <%--</div>--%>
<%--</div>--%>
<%--<div>--%>
  <%--<h4>NEW BLOG</h4>--%>
  <%--<!-- 最新文章 -->--%>
  <%--<div>--%>
    <%--<c:if test="${requestScope.recentBlogs != null}">--%>
      <%--<c:forEach items="${requestScope.recentBlogs}" var="blog">--%>
        <%--<a href="${blog.id}">${blog.title}</a>--%>
      <%--</c:forEach>--%>
    <%--</c:if>--%>
  <%--</div>--%>
<%--</div>--%>

<footer>
  <div class="container">
    <div class="row">
      <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
        <ul class="list-inline text-center">



          <!-- add Weibo, Zhihu by Hux, add target = "_blank" to <a> by Hux -->

          <%--<li>--%>
            <%--<a target="_blank" href="https://www.zhihu.com/people/huxpro">--%>
                            <%--<span class="fa-stack fa-lg">--%>
                                <%--<i class="fa fa-circle fa-stack-2x"></i>--%>
                                <%--<i class="fa  fa-stack-1x fa-inverse">知</i>--%>
                            <%--</span>--%>
            <%--</a>--%>
          <%--</li>--%>


          <%--<li>--%>
            <%--<a target="_blank" href="http://weibo.com/huxpro">--%>
                            <%--<span class="fa-stack fa-lg">--%>
                                <%--<i class="fa fa-circle fa-stack-2x"></i>--%>
                                <%--<i class="fa fa-weibo fa-stack-1x fa-inverse"></i>--%>
                            <%--</span>--%>
            <%--</a>--%>
          <%--</li>--%>




          <%--<li>--%>
            <%--<a target="_blank" href="https://www.facebook.com/huxpro">--%>
                            <%--<span class="fa-stack fa-lg">--%>
                                <%--<i class="fa fa-circle fa-stack-2x"></i>--%>
                                <%--<i class="fa fa-facebook fa-stack-1x fa-inverse"></i>--%>
                            <%--</span>--%>
            <%--</a>--%>
          <%--</li>--%>
            <li>
                <a target="_blank" href="mailto:${requestScope.admin.email}">
                            <span class="fa-stack fa-lg">
                                <i class="fa fa-circle fa-stack-2x"></i>
                        <i class="fa fa-envelope-o fa-stack-1x fa-inverse"></i>
                            </span>
                </a>
            </li>
            <li>
            <a target="_blank" href="${requestScope.admin.github}">
                            <span class="fa-stack fa-lg">
                                <i class="fa fa-circle fa-stack-2x"></i>
                                <i class="fa fa-github fa-stack-1x fa-inverse"></i>
                            </span>
            </a>
          </li>


        </ul>
        <p class="copyright text-muted">
          Copyright &copy; 2017 by iblog deveploer
          <br>
       </p>
      </div>
    </div>
  </div>
</footer>


<!-- footer -->
<%--<div class="footer-class">--%>
  <%--<a href="${requestScope.admin.github}">这里放一个github图标</a>--%>
  <%--<a href="mailto:${requestScope.admin.email}">这里放一个邮箱图标</a> &copy2017 by iblog developer--%>
<%--</div>--%>

<%@include file="regist.jsp"%>
<%@include file="login.jsp"%>

<script type="application/javascript" src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>
<script type="application/javascript" src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/regist.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/login.js"></script>
<script type="application/javascript" src="${pageContext.request.contextPath}/js/logout.js"></script>
</body>

</html>