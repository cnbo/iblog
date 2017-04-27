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
    <title>blog</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/editor-md/css/editormd.preview.css">

    <style>
        .editormd-html-preview {
            width: 90%;
            margin: 0 auto;
        }
    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}/index.do">${requestScope.admin.nickname}</a>

<a href="${pageContext.request.contextPath}/index.do">HOME</a>
<a href="${pageContext.request.contextPath}/author/resume.do">ABOUT</a>

<a href="#">LOGIN</a>
<a href="#">REGISTER</a>

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

<!-- footer -->
<div class="footer-class">
    <a href="${requestScope.admin.github}">这里放一个github图标</a>
    <a href="mailto:${requestScope.admin.email}">这里放一个邮箱图标</a>

    &copy2017 by iblog developer
</div>

    <script src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/marked.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/prettify.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/raphael.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/underscore.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/sequence-diagram.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/flowchart.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/jquery.flowchart.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/js/editormd.js"></script>
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
