<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-3-25
  Time: 下午3:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>admin profile</title>
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
        var resumeEditor;
        $(function () {
            resumeEditor = editormd("resume-editormd", {
                width               : "76%",
                height              : 540,
                syncScrolling       : "single",
                toolbarIcons        : function() {
                                        return ["undo", "redo", "|",
                                            "bold", "del", "italic", "quote", "uppercase", "|",
                                            "h1", "h2", "h3", "h4", "h5", "h6", "|",
                                            "list-ul", "list-ol", "hr", "|",
                                            "link", "reference-link", "datetime", "|",
                                            "goto-line", "watch", "preview", "fullscreen", "|",
                                            "search", "clear", "help"
                                        ]
                                    },
                path                : "${pageContext.request.contextPath}/lib/editor-md/lib/"
            });
//            $("#save-resume-btn").bind('click', function () {
//
//                $.ajax({
//                    type        : "POST",
//                    url         : "save/resume.do",
//                    success     : function (msg) {
//                        alert("save resume success");
//                    },
//                    data        : JSON.stringify({"resumeMd":resumeEditor.getMarkdown()}),
//                    dataType    : "json",
//                    contentType : "application/json; charset=utf-8"
//               });
//            });


            var btnCust = '<button type="button" class="btn btn-default" title="Add picture tags" ' +
                'onclick="alert(\'Call your custom code here.\')">' +
                '<i class="glyphicon glyphicon-tag"></i>' +
                '</button>';
            //初始化文件上传插件
            $("#avatar-file").fileinput({
//                theme : "explorer",
                language : "zh",
                uploadAsync : true,
                allowedFileExtensions : ["jpg", "png", "gif"],
                showUpload : false,
                overwriteInitial: true,
                maxFileSize: 1500,
                showClose: false,
                showCaption: false,
                browseLabel: '',
                removeLabel: '',
                browseIcon: '<i class="glyphicon glyphicon-folder-open"></i>',
                removeIcon: '<i class="glyphicon glyphicon-remove"></i>',
                removeTitle: 'Cancel or reset changes',
                elErrorContainer: '#kv-avatar-errors-1',
                msgErrorClass: 'alert alert-block alert-danger',
                defaultPreviewContent: '<img src="${pageContext.request.contextPath}/uploads/default_avatar.jpg" alt="Your Avatar" style="width:160px">',
                browseClass : "btn btn-primary"
            });


            $("#profile-form").submit(function () {
                $.ajax({
                    type : "POST",
                    url : "profile.do",
                    success : function (msg) {
                        alert("save success");
                    },
                    data : new FormData($("#profile-form")[0]),
                    processData : false,
                    contentType : false
                });

                return false;
            });

            $("#modify-password-form").submit(function () {
                $.ajax({
                    type : "POST",
                    url : "modify/pass.do",
                    success : function (msg) {
                        alert("modify success");
                    },
                    data : new FormData($("#modify-password-form")[0]),
                    processData : false,
                    contentType : false
                });

                return false;
            });
        });


        function saveResume() {
            $.ajax({
                type        : "POST",
                url         : "save/resume.do",
                success     : function (msg) {
                                alert(msg.resumeMd);
                            },
                data        : JSON.stringify({"resumeMd":resumeEditor.getMarkdown()}),
                dataType    : "json",
                contentType : "application/json; charset=utf-8"
            });
        }
    </script>
    <style>
        .kv-avatar .file-preview-frame,.kv-avatar .file-preview-frame:hover {
            margin: 0;
            padding: 0;
            border: none;
            box-shadow: none;
            text-align: center;
        }
        .kv-avatar .file-input {
            display: table-cell;
            max-width: 220px;
        }
    </style>
</head>
<body>
    <h2>个人信息</h2>
    <form id="profile-form" enctype="multipart/form-data">
        昵称 <input type="text" name="nickname" id="nickname">    <br>
        邮箱 <input type="email" name="email" id="email">         <br>
        GitHub <input type="url" name="github" id="github">       <br>
        座右铭 <input type="text" name="inroduction" id="inroduction"> <br>
        <div class="kv-avatar center-block" style="width:200px">
            头像 <input type="file" id="avatar-file" name="file" class="file-loading"> <br>
        </div>
        <%--头像 <input type="file" name="file">--%>
        <input type="submit" title="保存">
    </form>

    <h2>修改密码</h2>
    <form id="modify-password-form">
        旧密码 <input type="password" name="oldPassword" id="old-password"> <br>
        新密码 <input type="password" name="newPassword" id="new-password"> <br>
        确认密码 <input type="password" id="confrim-password"> <br>
        <input type="submit" title="保存">
    </form>

    <h2>个人简历</h2>
    <button id="save-resume-btn" onclick="saveResume()">保存</button>
    <div id="resume-editormd">
            <textarea name="resumeMd">

            </textarea>

    </div>

</body>
</html>