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
    <title>author resume</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/editor-md/css/editormd.preview.css">
    <script src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/marked.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/prettify.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/raphael.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/underscore.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/sequence-diagram.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/flowchart.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/lib/jquery.flowchart.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/editor-md/js/editormd.js"></script>
    <style>
        .editormd-html-preview {
            width: 90%;
            margin: 0 auto;
        }
    </style>
</head>
<body>

    <div id="layout">
    <div id="resume-editormd">
        <textarea id="append-test" style="display:none;">
${requestScope.adminDTO.resumeMd}
        </textarea>
    </div>
</div>

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
