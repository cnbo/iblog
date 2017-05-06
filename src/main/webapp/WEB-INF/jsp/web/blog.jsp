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


    <style>
        .editormd-html-preview {
            width: 90%;
            margin: 0 auto;
        }

        .comment-textarea {
            height: 90px;
            width: 480px;
            border: 1px solid #dcdcdc;
            background-color: hsla(0,0%,71%,.1);
            resize:none;  //去掉右下角的三角
        }

        .comment {
            margin-top: 15px;
        }

    </style>
</head>
<body>
<!-- blogId -->
<input type="hidden" id="blog-id" value="${requestScope.blog.id}">

<a href="${pageContext.request.contextPath}/index.do">${requestScope.admin.nickname}</a>

<a href="${pageContext.request.contextPath}/index.do">HOME</a>
<a href="${pageContext.request.contextPath}/author/resume.do">ABOUT</a>

<c:choose>
    <c:when test="${sessionScope.visitorName == null}">
        <a href="#" data-toggle="modal" data-target="#loginModal">LOGIN</a>
        <a href="#" data-toggle="modal" data-target="#registModal">REGISTER</a>
    </c:when>
    <c:otherwise>
        <img src="/iblog/uploads/monkey_logo.jpg"
             width="45" height="45"
             style="float: left; border-radius: 100%;"/>
        <a href="javascript:void(0);" onclick="logout()">LOGOUT</a>
        <input type="hidden" id="visitor-name" value="${sessionScope.visitorName}">
    </c:otherwise>
</c:choose>


<div>
    <h4>${blog.title}<h4>
    发表于<fmt:formatDate value="${blog.publishTime}"  pattern="yyyy-MM-dd HH:mm"/>
    浏览 ${blog.readTimes}
    评论 ${blog.commentTimes}
    喜欢 ${blog.loveTimes}
</div>

<div id="layout">
    <div id="blog-editormd">
        <textarea>
            ${requestScope.blog.blogMd}
        </textarea>
    </div>
</div>

<!-- 评论部分 -->
<div style="margin: 0 auto; max-width: 600px; display: block;">
    <div style="float: left; margin-right: 10px;">
        <img style="border-radius: 100%; " src="${pageContext.request.contextPath}/uploads/monkey_logo.jpg" width="45" height="45"/>
    </div>
    <c:choose>
        <c:when test="${sessionScope.visitorName == null}">
            <!-- 提示用户登录后才能评论 -->
            <div style="float: left; position: relative; border: 1px solid #dcdcdc; width: 480px; height: 90px; background-color: hsla(0,0%,71%,.1);">
                <div style="margin: 25px auto; width: 200px;">
                    <a href="#" data-toggle="modal" data-target="#loginModal" class="btn btn-primary">登录</a>
                    <span>后发表评论</span>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div style="float: left;">
                <input type='hidden' name='blogId'>
                <textarea id='write-comment-textarea' class='comment-textarea' placeholder='写下你的评论…' maxlength='2000'
                          onclick="showOpertateBtn();"></textarea>
                <div id="operate-btn">

                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>


<h2>评论</h2>
<!-- 展示评论 -->
<div id="comments-block" style="clear: both">

    <c:choose>
        <c:when test="${empty requestScope.commentsAndReplies}">
            无评论的显示仿简书
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
                                <div>
                                    <%--用户名--%>
                                    <span id="name-${commentAndReply.comment.id}">
                                        ${commentAndReply.visitor.visitorName}</span>
                                </div>
                                <div>
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
                    <div id="reply-block-${commentAndReply.comment.id}" style="border-left: 5px solid red;">
                        <c:if test="${not empty commentAndReply.blogCommentDTOS}">
                            <c:forEach items="${commentAndReply.blogCommentDTOS}" var="blogCommentDTO">
                                <div id="reply-${blogCommentDTO.comment.id}">
                                    <div>
                                        <div>
                                            <span id="name-${blogCommentDTO.comment.id}">
                                                ${blogCommentDTO.visitor.visitorName}</span>
                                            <span>：@</span>
                                            <span>${blogCommentDTO.parentVisitor.visitorName}&nbsp&nbsp</span>
                                            <spqn>${blogCommentDTO.comment.comment}</spqn>
                                        </div>
                                        <div>
                                            <span><fmt:formatDate value="${blogCommentDTO.comment.createTime}"
                                                                  pattern="yyyy-MM-dd HH:mm"/></span>
                                            <a href="javascript:void(0);"
                                               onclick="showReplyTextarea(${commentAndReply.comment.id},
                                               ${blogCommentDTO.comment.id})">回复</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <div id="add-comment-${commentAndReply.comment.id}">
                                <a href="javascript:void(0);"
                                   onclick="showReplyTextarea(${commentAndReply.comment.id},
                                    ${commentAndReply.comment.id})">添加新平论</a>
                            </div>
                        </c:if>
                        <c:if test="${empty commentAndReply.blogCommentDTOS}">
                            <div id="add-comment-${commentAndReply.comment.id}"></div>
                        </c:if>
                        <div id="reply-area-${commentAndReply.comment.id}"></div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

</div>

<!-- footer -->
<div class="footer-class">
    <a href="${requestScope.admin.github}">这里放一个github图标</a>
    <a href="mailto:${requestScope.admin.email}">这里放一个邮箱图标</a>

    &copy2017 by iblog developer
</div>


<%@include file="regist.jsp"%>
<%@include file="login.jsp"%>

    <script src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>
    <script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/marked.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/prettify.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/raphael.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/underscore.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/sequence-diagram.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/flowchart.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/jquery.flowchart.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/js/editormd.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/regist.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/login.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/js/logout.js"></script>
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
            $("#operate-btn").html(
                "<a href='javascript:void(0);' type='button' onclick='cancleComment()'>取消</a> " +
                "<a href='javascript:void(0);' type='button' class='btn btn-primary' " +
                "onclick='publishComment()'>发表</a>");
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
                                "<div>" +
                                    "<span>" + visitorName + "</span>" +
                                "</div>" +
                                "<div>" +
                                    "<span>" + createTime + "</span>" +
                                "</div>" +
                            "</div>" +
                        "</div>" +
                        "<div id='comment-content' style='margin-top: 10px;'>" +
                            "<span>" + blogComment.comment + "</span>" +
                        "</div>" +
                        "<div id='comment-footer'>" +
                            "<a href='javascript:void(0);' id='a-" + commentId + "'>回复</a>" +
                        "</div>" +
                    "</div>" +
                    "<div id='reply-block-" + commentId + "' style='border-left: 5px solid red;'>" +
                        "<div id='add-comment-" + commentId + "'></div>" +
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

        function showReplyTextarea(commentId, replyCommentId) {
            var replyTextareaHtml = "";
            replyTextareaHtml += "<form class='new-comment' style='display: block; '>" +
                                    "<div class='panel-body comment-text'>" +
                                        "<textarea id='reply-textarea-" + commentId + "'" +
                                                "class='comment-textarea' placeholder='写下你的评论…' " +
                                                "maxlength='2000'></textarea>" +
                                        "<div>" +
                                            "<a href='javascript:void(0);' type='button' " +
                                                "onclick='cancleReply(" + commentId + ")'>取消</a>" +
                                            "<a href='javascript:void(0);' type='button' " +
                                                    "class='btn btn-primary' " +
                                                 "id='publish-reply-" + replyCommentId + "'>发表</a>" +
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
                                            "<a href='javascript:void(0);' >添加新平论</a>";
                                        $("#add-comment-"+commentId).html(addCommentHtml);
                                        $("#add-comment-"+commentId+" > a").click(function () {
                                            showReplyTextarea(commentId, replyCommentId);
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
            var replyVisitorName = superCommentId != replyCommentId ? $("#name-"+replyCommentId).val() : "";
            var createTime = formatDate(blogComment.createTime);
            var replyHtml =
                "<div id='reply-" + commentId + "'>" +
                    "<div>" +
                        "<div>" +
                            "<span id='name-" + commentId + "'>" + visitorName + "</span>" +
                            "<span>：@</span>" +
                            "<span>" + replyVisitorName + "</span>" +
                            "<spqn>" + blogComment.comment + "</spqn>" +
                        "</div>" +
                        "<div>" +
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
