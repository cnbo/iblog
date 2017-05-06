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
        ${sessionScope.visitorName}
        <a href="javascript:void(0);" onclick="logout()">LOGOUT</a>
    </c:otherwise>
</c:choose>


<div>
    <h4>${blog.title}<h4>
    发表于<fmt:formatDate value="${blog.publishTime}"  dateStyle="long"/>
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

<!-- 展示评论 -->
<div id="comments-block" style="clear: both">
    <!-- 一级评论 -->
    <div id="comment-1" class="one-level-comment" >
        <div>
            <div id="comment-header">
                <img src="${pageContext.request.contextPath}/uploads/monkey_logo.jpg" width="45" height="45"
                style="float: left; border-radius: 100%;"/>
                <div>
                    <div>
                        <span>用户A</span>
                    </div>
                    <div>
                        <span>2017-5-1</span>
                    </div>
                </div>
            </div>
            <div id="comment-content" style="margin-top: 10px;">
                <span>this is a good blog!</span>
            </div>
            <div id="comment-footer">
                <a href="javascript:void(0);" onclick="showReplyTextarea(1)">回复</a>
            </div>
        </div>

        <!-- 一级评论下的回复 -->
        <div id="reply-block-1" style="border-left: 5px solid red;">
            <div id="comment-3">
                <div>
                    <div>
                        <span>用户B</span>：@<span>用户A&nbsp&nbsp</span> <spqn>your's comment is interesting</spqn>
                    </div>
                    <div>
                        <span>2017-5-1</span>
                        <a href="javascript:void(0);" onclick="showReplyTextarea(1)">回复</a>
                    </div>
                </div>
            </div>
            <div id="add-comment-1">
                <a href="javascript:void(0);" onclick="showReplyTextarea(1)">添加新平论</a>
            </div>
            <div id="reply-textarea-1">

            </div>
        </div>
    </div>


    <input id="last-comment-id" type="hidden" value="comment-1"/>
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
            $("#operate-btn").html("<a href='javascript:void(0);' type='button' onclick='cancleComment()'>取消</a> " +
                "<a href='javascript:void(0);' type='button' class='btn btn-primary' onclick='publishComment()'>发表</a>");
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
                                    var commentHtml = generateOneLevelCommentHtml(msg);
                                    var lastCommentId = $("#last-comment-id").val();
                                    $("#" + lastCommentId).after(commentHtml);
                                }
                            },
                error       : function () {
                                alert("服务器请求失败");
                            }
            });


        }

        function generateOneLevelCommentHtml(blogComment) {
            var commentHtml =
                "<div id='" + blogComment.id + "' class='one-level-comment'>" +
                    "<div id='comment-header'>" +
                        "<img src='${pageContext.request.contextPath}/uploads/monkey_logo.jpg' width='45' height='45'" +
                        "style='float: left; border-radius: 100%;'/>" +
                        "<div>" +
                            "<div>" +
                            "<span>${sessionScope.visitorName}}</span>" +
                            "</div>" +
                        "<div>" +
                        "<span>2017-5-1</span>" +
                    "</div>" +
                    "</div>" +
                    "</div>" +
                    "<div id='comment-content' style='margin-top: 10px;'>" +
                        "<span>" + blogComment.comment + "</span>" +
                    "</div>" +
                    "<div id='comment-footer'>" +
                        "<a href='javascript:void(0);' onclick='showReplyTextarea(" + blogComment.id + ")'>回复</a>" +
                    "</div>" +
                "</div>" +
                "<div id='reply-block-" + blogComment.id + "' style='border-left: 5px solid red;'>" +
                    "<div id='add-comment-1" + blogComment.id + "'></div>" +
                    "<div id='reply-textarea-" + blogComment.id + "'></div>" +
                "</div>";

            return commentHtml;
        }

        function showReplyTextarea(id) {
            var replyTextareaHtml = "";
            replyTextareaHtml += "<form class='new-comment' style='display: block; '>" +
                                    "<div class='panel-body comment-text'>" +
                                        "<input type='hidden' name='blogId'>" +
                                        "<textarea id='write-comment-textarea' class='comment-textarea' placeholder='写下你的评论…' maxlength='2000'></textarea>" +
                                        "<div>" +
                                            "<a href='javascript:void(0);' type='button' onclick='cancleReply(" + id + ")'>取消</a>" +
                                            "<a href='javascript:void(0);' type='button' class='btn btn-primary' onclick='publishComment()'>发表</a>" +
                                        "</div>" +
                                    "</div>" +
                                "</form>";
            $("#reply-textarea-" + id).html(replyTextareaHtml);

        }

        function cancleReply(id) {
            $("#reply-textarea-" + id).html("");
        }


    </script>
</body>
</html>
