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
