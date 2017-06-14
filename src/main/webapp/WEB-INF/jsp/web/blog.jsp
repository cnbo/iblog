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
    <title>blog</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/editor-md/css/editormd.preview.css">
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.css">

 <!-- Custom CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hux-blog.min.css">
  <link href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <%--<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.css">--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/comment.css">
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
                <input type="hidden" id="visitor-name" value="${sessionScope.visitorName}">
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
          <h1>${blog.title}</h1>
          <!--<hr class="small">-->
          <span class="subheading">
            ${requestScope.admin.introduction}
          </span>
            <span class="meta">
              <fmt:formatDate value="${blog.publishTime}" pattern="yyyy-MM-dd HH:mm" /> 浏览 ${blog.readTimes} 评论 ${blog.commentTimes}
            </span>
        </div>
      </div>
    </div>
  </div>
</header>


<div id="layout">
    <div id="blog-editormd"><textarea>${requestScope.blog.blogMd}</textarea></div>
</div>

<!-- 评论部分 -->
<div style="margin: 100px auto; width: 600px;; display: block;">
    <div style="display: inline-block; vertical-align: middle; margin-right: 10px;">
        <img style="border-radius: 100%; " src="${pageContext.request.contextPath}/uploads/monkey_logo.jpg" width="45" height="45"/>
    </div>
    <c:choose>
        <c:when test="${sessionScope.visitorName == null}">
            <!-- 提示用户登录后才能评论 -->
            <div style="display: inline-block; position: relative; border: 1px solid #dcdcdc; width: 480px; height: 90px; background-color: hsla(0,0%,71%,.1);">
                <div style="margin: 25px auto; width: 200px;">
                    <a href="#" data-toggle="modal" data-target="#loginModal" class="btn btn-primary">登录</a>
                    <span>后发表评论</span>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div style="display:inline-block;">
                <input type='hidden' name='blogId'>
                <textarea id='write-comment-textarea' class='comment-textarea' placeholder='写下你的评论…' maxlength='2000'
                          onclick="showOpertateBtn();"></textarea>
                <div class="operate-btn">

                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>


<!-- 展示评论 -->
<div id="comments-block" style="clear: both">
    <div class="top">
        <span>评论</span>
    </div>
    <c:choose>
        <c:when test="${empty requestScope.commentsAndReplies}">
            <div id="no-comment">
                <div class="pic"></div>
                <div class="text">
                    智慧如你，不想
                    <a>发表一点看法</a>
                    咩？
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${requestScope.commentsAndReplies}" var="commentAndReply">
                <!-- 一级评论 -->
                <div id="comment-${commentAndReply.comment.id}" class="comment" >
                    <div>
                        <div id="comment-header">
                            <%--用户头像--%>
                            <img src="/iblog/uploads/monkey_logo.jpg"
                                 width="45" height="45"
                                 style="float: left; border-radius: 100%;"/>
                            <div>
                                <div class="comment-info">
                                    <%--用户名--%>
                                    <span id="name-${commentAndReply.comment.id}">
                                        ${commentAndReply.visitor.visitorName}</span>
                                </div>
                                <div class="comment-info">
                                    <%--评论时间--%>
                                    <span><fmt:formatDate value="${commentAndReply.comment.createTime}"
                                                          pattern="yyyy-MM-dd HH:mm"/></span>
                                </div>
                            </div>
                        </div>
                        <div id="comment-content" style="margin-top: 10px;">
                            <%--评论内容--%>
                            <span>${commentAndReply.comment.comment}</span>
                        </div>
                        <div id="comment-footer">
                            <a href="javascript:void(0);"
                               onclick="showReplyTextarea(${commentAndReply.comment.id},
                                   ${commentAndReply.comment.id})">回复</a>
                        </div>
                    </div>

                    <!-- 一级评论下的回复 -->
                    <div class='reply-block' id="reply-block-${commentAndReply.comment.id}" >
                        <c:if test="${not empty commentAndReply.blogCommentDTOS}">
                            <c:forEach items="${commentAndReply.blogCommentDTOS}" var="blogCommentDTO">
                                <div id="reply-${blogCommentDTO.comment.id}">
                                    <div>
                                        <div class="commentC">
                                            <span id="name-${blogCommentDTO.comment.id}">${blogCommentDTO.visitor.visitorName}</span>
                                            <span>：@</span>
                                            <span>${blogCommentDTO.parentVisitor.visitorName}&nbsp&nbsp</span>
                                            <spqn>${blogCommentDTO.comment.comment}</spqn>
                                        </div>
                                        <div class="dateTime">
                                            <span><fmt:formatDate value="${blogCommentDTO.comment.createTime}"
                                                                  pattern="yyyy-MM-dd HH:mm"/></span>
                                            <a class="reply"
                                               onclick="showReplyTextarea(${commentAndReply.comment.id},
                                               ${blogCommentDTO.comment.id})">回复</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <div  class='addComment' id="add-comment-${commentAndReply.comment.id}">
                                <a onclick="showReplyTextarea(${commentAndReply.comment.id},
                                    ${commentAndReply.comment.id})">添加新评论</a>
                            </div>
                        </c:if>
                        <c:if test="${empty commentAndReply.blogCommentDTOS}">
                            <div class="addComment" id="add-comment-${commentAndReply.comment.id}"></div>
                        </c:if>
                        <div id="reply-area-${commentAndReply.comment.id}"></div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

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

        function showOpertateBtn() {
            $(".operate-btn").html(
                "<a href='javascript:void(0);' type='button'  class='submit btn btn-primary' " +
                "onclick='publishComment()'>发表</a>" +
                "<a href='javascript:void(0);' type='button' class='cancel' onclick='cancleComment()'>取消</a>"
            )
        }

        function cancleComment() {
            $("#write-comment-textarea").val("");
            $("#operate-btn").html("");
        }
        
        function publishComment() {
            var blogId = $("#blog-id").val();
            var comment = $("#write-comment-textarea").val();

            $.ajax({
                type        : "POST",
                url         : "comment.do",
                data        : JSON.stringify({"blogId":blogId, "comment":comment}),
                dataType    : "json",
                contentType : "application/json; charset=utf-8",
                success     : function (msg) {
                                if (msg.id > 0) {
                                    var commentHtml = generateCommentHtml(msg);
                                    $("#comments-block").append(commentHtml);
                                    cancleComment();
                                    $("#a-"+msg.id).click(function () {
                                        showReplyTextarea(msg.id, msg.id);
                                    });
                                }
                            },
                error       : function () {
                                alert("服务器请求失败");
                            }
            });


        }

        function generateCommentHtml(blogComment) {
            var visitorName = $("#visitor-name").val();
            var commentId = blogComment.id;
            var createTime = formatDate(blogComment.createTime);
            var commentHtml =
                "<div id='comment-$" + commentId + "' class='comment' >" +
                    "<div>" +
                        "<div id='comment-header'>" +
                            "<img src='/iblog/uploads/monkey_logo.jpg'" +
                                "width='45' height='45' style='float: left; border-radius: 100%;'/>" +
                            "<div>" +
                                "<div class='comment-info' >" +
                                    "<span id='name-" + commentId + "'>" + visitorName + "</span>" +
                                "</div>" +
                                "<div class='comment-info'>" +
                                    "<span>" + createTime + "</span>" +
                                "</div>" +
                            "</div>" +
                        "</div>" +
                        "<div id='comment-content' style='margin-top: 10px;'>" +
                            "<span>" + blogComment.comment + "</span>" +
                        "</div>" +
                        "<div id='comment-footer'>" +
                            "<a id='a-" + commentId + "'>回复</a>" +
                        "</div>" +
                    "</div>" +
                    "<div class='reply-block' id='reply-block-" + commentId + "'>" +
                        "<div class='addComment' id='add-comment-" + commentId + "'></div>" +
                        "<div id='reply-area-" + commentId + "'></div>" +
                    "</div>" +
                "</div>";

            return commentHtml;
        }

        function formatDate(createTime) {
            var date = new Date(createTime);
            var year = date.getFullYear();
            var month = date.getMonth();
            var day = date.getDay();
            var hour = date.getHours();
            var minute = date.getMinutes();

            month = month < 10 ? ("0" + month) : month;
            day = day < 10 ? ("0" + day) : day;
            hour = hour < 10 ? ("0" + hour) : hour;
            minute = minute < 10 ? ("0" + minute) : minute;

            createTime = year + "-" + month + "-" + day + " " + hour + ":" + minute;
            return createTime;
        }

        function checkLogin() {
            var visitorName = $("#visitor-name");
            if (visitorName.length > 0) {
                return true;
            } else {
                return false;
            }
        }

        function showReplyTextarea(commentId, replyCommentId) {
            var isLogin = checkLogin();
            if (!isLogin) {
                alert("请先登录!");
                return;
            }
            var replyTextareaHtml = "";
            replyTextareaHtml += "<form class='new-comment' style='display: block; '>" +
                                    "<div class='panel-body comment-text'>" +
                                        "<textarea tyle='width: 567px'  id='reply-textarea-" + commentId + "'" +
                                                "class='comment-textarea' placeholder='写下你的评论…' " +
                                                "maxlength='2000'></textarea>" +
                                        "<div class='operate-btn'>" +
                                            "<a href='javascript:void(0);' type='button' " +
                                                    "class='submit btn btn-primary' " +
                                                 "id='publish-reply-" + replyCommentId + "'>发表</a>" +
                                            "<a href='javascript:void(0);' class='cancel' type='button' " +
                                            "onclick='cancleReply(" + commentId + ")'>取消</a>" +
                                        "</div>" +
                                    "</div>" +
                                "</form>";
            $("#reply-area-" + commentId).html(replyTextareaHtml);
            $("#publish-reply-"+replyCommentId).click(function () {
                publishReply(commentId, replyCommentId);
            });
        }

        function publishReply(commentId, replyCommentId) {
            var blogId = $("#blog-id").val();
            var replyComment = $("#reply-textarea-"+commentId).val();

            $.ajax({
                type        : "POST",
                url         : "comment.do",
                data        : JSON.stringify({"blogId":blogId, "comment":replyComment,
                                                "replyCommentId":replyCommentId}),
                dataType    : "json",
                contentType : "application/json; charset=utf-8",
                success     : function (msg) {
                                if (msg.id > 0) {
                                    var replyHtml = generateReplyHtml(commentId, replyCommentId, msg);
                                    $("#add-comment-"+commentId).before(replyHtml);
                                    cancleReply(commentId);
                                    $("#a-"+msg.id).click(function () {
                                        showReplyTextarea(commentId, msg.id);
                                    });
                                    if ($("#add-comment-"+commentId).html().length <= 0) {
                                        var addCommentHtml =
                                            "<a onclick='showReplyTextarea(commentId, commentId)'>添加新评论</a>";
                                        $("#add-comment-"+commentId).html(addCommentHtml);
                                        $("#add-comment-"+commentId+" > a").click(function () {
                                            showReplyTextarea(commentId, commentId);
                                        });
                                    }
                                }
                            },
                error       : function () {
                                alert("服务器请求失败");
                            }
            });


        }

        function generateReplyHtml(superCommentId, replyCommentId, blogComment) {
            var commentId = blogComment.id;
            var visitorName = $("#visitor-name").val();
            var replyVisitorName = $("#name-"+replyCommentId).text();
            var createTime = formatDate(blogComment.createTime);
            var replyHtml =
                "<div id='reply-" + commentId + "'>" +
                    "<div>" +
                        "<div class='commentC'>" +
                            "<span id='name-" + commentId + "'>" + visitorName + "</span>" +
                            "<span>：@</span>" +
                            "<span>" + replyVisitorName + "&nbsp&nbsp</span>" +
                            "<spqn>" + blogComment.comment + "</spqn>" +
                        "</div>" +
                        "<div class='dateTime'>" +
                            "<span>" + createTime + "</span>" +
                            "<a href='javascript:void(0);' id='a-" + commentId + "'>回复</a>" +
                        "</div>" +
                    "</div>" +
                "</div>";

            return replyHtml;
        }

        function cancleReply(id) {
            $("#reply-area-" + id).html("");
        }


    </script>
</body>
</html>
