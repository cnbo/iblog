<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-4-1
  Time: 下午4:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@include file="header.jsp" %>
<link type="text/css" media="all" rel="stylesheet" href="${pageContext.request.contextPath}/lib/bootstrap-fileinput/css/fileinput.css">
<link type="text/css" media="all" rel="stylesheet" href="${pageContext.request.contextPath}/lib/editor-md/css/editormd.css">
<style>
    .box-header.with-border {
        border-bottom: 1px solid #f4f4f4;
    }

    .box-header {
        color: #444;
        display: block;
        padding: 10px;
        position: relative;
    }

    .box-header .box-title {
        display: inline-block;
        font-size: 18px;
        margin: 0;
        line-height: 1;
    }

    .box.box-info {
        border-top-color: #00c0ef;
    }

    .box.box-danger {
        border-top-color: #dd4b39;
    }

    .box-body {
        border-top-left-radius: 0;
        border-top-right-radius: 0;
        border-bottom-right-radius: 3px;
        border-bottom-left-radius: 3px;
        padding: 10px;
    }

    .container {
        margin: 0px;
        padding-left: 30px;
    }

    .box-footer {
        border-top-left-radius: 0;
        border-top-right-radius: 0;
        border-bottom-right-radius: 3px;
        border-bottom-left-radius: 3px;
        border-top: 1px solid #f4f4f4;
        padding: 10px;
        background-color: #fff;
    }

    .box {
        position: relative;
        border-radius: 3px;
        background: #ffffff;
        border-top: 3px solid #d2d6de;
        margin-bottom: 20px;
        width: 100%;
        box-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);
    }

    .box-header:after,
    .box-body::after,
    .box-footer::after {
        content: '';
        display: table;
        clear: both;
    }

    .box-header:before,
    .box-body::before,
    .box-footer::before {
        content: '';
        display: table;
    }

    .kv-avatar .file-preview-frame,
    .kv-avatar .file-preview-frame:hover {
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

<div class="row">
    <div class="col-md-6">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class=box-title>个人信息</h3>
            </div>

            <form id="profile-form" enctype="multipart/form-data" class="form-horizontal">
                <div class="box-body">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">昵称</label>
                        <div class="col-sm-10">
                            <input value="${requestScope.admin.nickname}" type="text" class="form-control"
                                   placeholder="请输入昵称" name="nickname" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮件</label>
                        <div class="col-sm-10">
                            <input value="${requestScope.admin.email}" type="text" class="form-control"
                                   placeholder="请输入邮箱地址" name="email" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">Github</label>
                        <div class="col-sm-10">
                            <input value="${requestScope.admin.github}" type="text" class="form-control"
                                   placeholder="请输入Github昵称" name="github" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">座右铭</label>
                        <div class="col-sm-10">
                            <input value="${requestScope.admin.introduction}" type="text" class="form-control"
                                   placeholder="请输入座右铭" name="introduction" >
                        </div>
                    </div>
                    <div class="form-group kv-avatar center-block">
                        <label class="col-sm-2 control-label">头像</label>
                        <div class="col-sm-10">
                            <input value="${requestScope.admin.avatar}" type="file" class="form-control file-loading" name="avatar"
                                   id="avatar-file">
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <button class="btn btn-primary pull-right" type="submit">保存</button>
                </div>

            </form>

        </div>
        <div class="box box-danger">

            <div class="form-horizontal">
                <div class="box-header with-border">
                    <h3 class=box-title>修改密码</h3>
                </div>
                <div class="box-body">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">旧密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" name="oldPassword"
                            id="old-pass">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">新密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" name="newPassword"
                            id="new-pass">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" name="confirmPassword"
                            id="confirm-pass">
                        </div>
                    </div>

                </div>
                <div class="box-footer">
                    <button class="btn btn-primary pull-right" onclick="modifyPass()">保存</button>
                </div>
            </div>
        </div>
    </div>
</div>


<h3>个人简历</h3>
<div id="resume-editormd" style="margin: 0px">
    <input type="hidden" value="${requestScope.admin.resumeMd}" id="resume">
<textarea name="resumeMd">${requestScope.admin.resumeMd}</textarea>

    <button id="save-resume-btn" class="btn btn-primary pull-right" onclick="saveResume()">保存</button>
</div>

<%@include file="footer.jsp" %>

<%--<script type="application/javascript" src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>--%>
<%--<script type="application/javascript" src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>--%>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/canvas-to-blob.js"></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/sortable.js"></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/purify.js"></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/fileinput.js"></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/zh.js"></script>
<script type="application/javascript" src="${pageContext.request.contextPath}/lib/editor-md/js/editormd.js"></script>
<script type="application/javascript">
    var resumeEditor;
    $(function() {
        resumeEditor = editormd("resume-editormd", {
            width: "76%",
            height: 540,
            syncScrolling: "single",
            toolbarIcons: function () {
                return ["undo", "redo", "|",
                    "bold", "del", "italic", "quote", "uppercase", "|",
                    "h1", "h2", "h3", "h4", "h5", "h6", "|",
                    "list-ul", "list-ol", "hr", "|",
                    "link", "reference-link", "datetime", "|",
                    "goto-line", "watch", "preview", "fullscreen", "|",
                    "search", "clear", "help"
                ]
            },
            path: "../lib/editor-md/lib/"
        });


        var btnCust = '<button type="button" class="btn btn-default" title="Add picture tags" ' +
            'onclick="alert(\'Call your custom code here.\')">' +
            '<i class="glyphicon glyphicon-tag"></i>' +
            '</button>';
//初始化文件上传插件
            $("#avatar-file").fileinput({
    //                theme : "explorer",
                language: "zh",
                uploadAsync: true,
                allowedFileExtensions: ["jpg", "png", "gif"],
                showUpload: false,
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
                defaultPreviewContent: '<img src="../uploads/default_avatar.jpg" alt="Your Avatar" style="width:160px">',
                browseClass: "btn btn-primary"
            });


        $("#profile-form").submit(function () {
            $.ajax({
                type: "POST",
                url: "profile.do",
                data: new FormData($("#profile-form")[0]),
                processData: false,
                contentType: false,
                success: function (msg) {
                    alert("save success");
                },
                error: function () {
                    tale.alertError("访问失败");
                }

            });

            return false;
        });


    });

    function modifyPass() {
        var newPassword = $("#new-pass").val();
        var oldPassword = $("#old-pass").val();
        var confirmPass = $("#confirm-pass").val();
        if (newPassword != confirmPass) {
            alert("两次新密码输入不一致");
            return;
        }

        $.ajax({
            type : "POST",
            url  : "modify/pass.do",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data : JSON.stringify({"newPassword":newPassword, "oldPassword":oldPassword}),
            success: function(msg) {
                if (msg == true) {
                    tale.alertOk("密码修改成功");
                } else {
                    tale.alertError("密码修改失败");
                }
            },
            error: function() {
                tale.alertError("访问失败");
            }

        });
    }

    var preResumeContent = $("#resume").val();

    //每3秒保存一次文章
    setInterval("autoSave()", 3000);

    function autoSave() {
        var nowResumeContent = resumeEditor.getMarkdown();
        if (preResumeContent.length == nowResumeContent.length && nowResumeContent == preResumeContent) {
            return;
        }

        saveResume();
    }

    function saveResume() {
        $.ajax({
            type: "POST",
            url: "save/resume.do",
            success: function (msg) {
//                alert(msg.resumeMd);
                    if (msg > 0) {
                        preResumeContent = resumeEditor.getMarkdown();
                    }
            },
            error: function () {
                tale.alertError("访问失败");
            },
            data: JSON.stringify({
                "resumeMd": resumeEditor.getMarkdown()
            }),
            dataType: "json",
            contentType: "application/json; charset=utf-8"
        });
    }
</script>



<%--<script type="application/javascript" src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>--%>
<%--<script type="application/javascript"--%>
<%--src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>--%>
</body>
</html>
