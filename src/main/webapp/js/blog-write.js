var blogEditor, blogId = "", status = 0;
var updateUrl = "update.do";
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


function getJsonData(type) {
    var categoryName = $("#category-select").find("option:selected").text();
    var categoryId = $("#category-select").val();
    var title = $("#title").val();
    var blogMd = blogEditor.getMarkdown();

    switch (type) {
        case "save":
            return JSON.stringify({"categoryId":categoryId,
                "categoryName":categoryName,
                "title":title, "blogMd":blogMd});
        case "update":
            return JSON.stringify({"categoryId":categoryId,
                "categoryName":categoryName,
                "title":title, "blogMd":blogMd,
                "id":blogId});
        case "draftOrPublish":
            return JSON.stringify({"categoryId":categoryId,
                "categoryName":categoryName,
                "title":title, "blogMd":blogMd,
                "id":blogId,
                "status":status});
    }
}

function saveOrUpdateBlog() {
    var editInput = $("#edit-id");
    if (editInput.length > 0) {
        blogId = editInput.val();
        updateUrl = "../update.do";
    }
    if (blogId == "") {
        saveBlog();
    } else {
        updateBlog(getJsonData("update"));
    }
}

function saveBlog() {
    var dataJSON = getJsonData("save");
    $.ajax({
        type         : "POST",
        url          : "save.do",
        dataType     : "json",
        contentType  : "application/json;charset=utf-8",
        data         : dataJSON,
        success      : function (msg) {
            if (msg > 0) {
                blogId = msg;
                alert("save blog success");
            } else {
                alert("save failure");
            }
        },
        error        : function () {
            alert("访问失败");
        }
    });
}

function updateBlog(dataJSON) {
    $.ajax({
        type         : "POST",
        url          : updateUrl,
        dataType     : "json",
        contentType  : "application/json;charset=utf-8",
        data         : dataJSON,
        success      : function (msg) {
            if (msg > 0) {
                alert("update blog success");
            } else {
                alert("update failure");
            }
        },
        error        : function () {
            alert("访问失败");
        }
    });
}

function updateStatus(statusVal) {
    status = statusVal;
    updateBlog(getJsonData("draftOrPublish"));
}
