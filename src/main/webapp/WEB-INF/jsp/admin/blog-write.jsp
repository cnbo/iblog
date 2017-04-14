<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-4-1
  Time: 下午4:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>write blog</title>
    <%--Bootstrap css--%>
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.css">
    <%--bootstrap-fileinput css--%>
    <link type="text/css" media="all" rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/bootstrap-fileinput/css/fileinput.css">
    <%--eitor.md css--%>
    <link type="text/css" media="all" rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/editor-md/css/editormd.css">
    <%--jqeury--%>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>
    <%--bootstrap js--%>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>
    <%--bootstrap-fileinput js--%>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/canvas-to-blob.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/sortable.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/purify.js    "></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/fileinput.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/zh.js"></script>
    <%--editor.md js--%>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/editor-md/js/editormd.js"></script>
    <script type="application/javascript">
        var blogEditor;
        $(function () {
            blogEditor = editormd("blog-editor", {
                width               : "76%",
                height              : 540,
                syncScrolling       : "single",
                toolbarIcons        : function() {
                    return ["undo", "redo", "|",
                        "bold", "del", "italic", "quote", "ucwords", "uppercase", "lowercase", "|",
                        "h1", "h2", "h3", "h4", "h5", "h6", "|",
                        "list-ul", "list-ol", "hr", "|",
                        "link", "reference-link", "image", "code", "preformatted-text",
                        "code-block", "table", "datetime", "html-entities", "pagebreak",  "|",
                        "goto-line", "watch", "preview", "fullscreen", "|",
                        "search", "clear", "help"
                    ]
                },
                path                : "${pageContext.request.contextPath}/lib/editor-md/lib/"
            });
        });


        function saveBlog() {
            var dataJSON = JSON.stringify({"id":id, "categoryID":categoryID,
                                            "categoryName":categoryName,
                                            "title":title, "blogMD":blogMD});
            $.ajax({
                type         : "POST",
                url          : "save.do",
                dataType     : "json",
                contentType  : "application/json;charset=utf-8",
                data         : dataJSON,
                success      : function (msg) {
                    alert("save success");
                },
                error        : function () {
                    alert("访问失败");
                }
            });
        }

    </script>
</head>
<body>

    <input type="text" name="title" id="title" value="无标题文章"> <br>
    <select id="category">
        <c:if test="${ empty requestScope.blogCategories}">
            <option>java</option>
        </c:if>
        <c:if test="${requestScope.blogCategories != null}">
            <c:forEach items="${requestScope.blogCategories}" var="category">
                <option value="${category.id}">${category.categoryName}</option>
            </c:forEach>
        </c:if>
    </select> <br>
    <button id="save-btn">保存</button>
    <button id="publish-btn">发布</button>
    <button id="draft-btn">存为草稿</button>


    <h3>blog</h3>
    <div id="blog-editor">
        <textarea></textarea>
    </div>
</body>
</html>
