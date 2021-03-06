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
    <meta charset="UTF-8">
    <title>about</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/editor-md/css/editormd.preview.css">
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hux-blog.min.css">
    <link href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <%--<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.css">--%>
    <style>
        .editormd-html-preview {
            width: 65%;
            margin: 0 auto;
        }

    </style>
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
<!-- blogId -->

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

<input type="hidden" id="blog-id" value="${requestScope.blog.id}">
<!-- Page Header -->
<header class="intro-header" style="background-image: url('${pageContext.request.contextPath}/uploads/home-bg.jpg')">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 ">
                <div class="post-heading">
                    <h1>Who am I?</h1>
                    <!--<hr class="small">-->
                    <span class="subheading">
                        ${requestScope.adminDTO.introduction}
                    </span>
                </div>
            </div>
        </div>
    </div>
</header>


<div id="layout">
    <div id="blog-editormd">
        <textarea>
            ${requestScope.adminDTO.resumeMd}
        </textarea>
    </div>
</div>

<!-- footer -->
<%@include file="footer.jsp"%>


<%@include file="regist.jsp"%>
<%@include file="login.jsp"%>

<script src="${pageContext.request.contextPath}/lib/js/jquery-1.12.4.js"></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>
<%@include file="../common/editor.jsp"%>
<%@include file="../common/visitor-js.jsp"%>
<script type="text/javascript">
    $(function() {
        var blogEditormd;

        blogEditormd = editormd.markdownToHTML("blog-editormd", {
            htmlDecode      : "style,script,iframe",  // you can filter tags decode
            emoji           : true,
            taskList        : true,
            tex             : true,  // 默认不解析
            flowChart       : true,  // 默认不解析
            sequenceDiagram : true   // 默认不解析
        });

    });

</script>
</body>
</html>
