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
    <title>iblog</title>
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
        ${requestScope.admin.introduction}
    </div>


    <div id="layout">
        <div id="resume-editormd">
            <textarea id="append-test" style="display:none;">
                iblog index
            </textarea>
        </div>
    </div>

    <!-- 全文搜索框 -->
    <div>
        <input type="text" id="search-key"><a href="#">搜索</a>
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

    <!-- 类别 -->
    <div id="category-div">
        <h4>BLOG CATEGORY</h4>
        <c:if test="${requestScope.categories != null}">
            <c:forEach items="${requestScope.categories}" var="category">
                <a href="${category.id}">${category.categoryName}</a>
            </c:forEach>
        </c:if>
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
            var resumeEditormd;

            resumeEditormd = editormd.markdownToHTML("resume-editormd", {
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
