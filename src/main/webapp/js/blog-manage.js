var currentPage, pages;
var pageNextHtml = "<button onclick='getBlogByPage(currentPage+1)'>下一页</button>";
var pagePreviousHtml = "<button onclick='getBlogByPage(currentPage-1)'>上一页</button>";
var searchKey;
var blogs;

$(function () {
    getBlogByPage(1);
});

function getBlogByPage(page) {
    var dataJSON;
    if (searchKey != "" && searchKey != null) {
        dataJSON = JSON.stringify({"page":page, "title":searchKey});
    } else {
        dataJSON = JSON.stringify({"page":page});
    }
    $.ajax({
        type        : "POST",
        url         : "page.do",
        success     : function (msg) {
                        refresh(msg);
                    },
        error       : function () {
                        alert("服务器请求失败");
                    },
        data        : dataJSON,
        dataType    : "json",
        contentType : "application/json; charset=utf-8"
    });
}


function refresh(msg) {
    blogs = msg.blogs;
    pages = msg.pages;
    currentPage = msg.page;

    var table = "<table>" +
        "<thead>" +
        "<tr>" +
        "<th>ID</th>" +
        "<th>标题</th>" +
        "<th>创建时间</th>" +
        "<th>修改时间</th>" +
        "<th>发布时间</th>" +
        "<th>浏览次数</th>" +
        "<th>点赞次数</th>" +
        "<th>评论次数</th>" +
        "<th>操作</th>" +
        "</tr>" +
        "<thead>";
    for (var index = 0; index < blogs.length; index++) {
        var blog = blogs[index];
        var id = blog.id;
        var title = blog.title;
        table += "<tr>" +
            "<td>" + id + "</td>" +
            "<td><input id='title-input-" + id + "' value='" +
            title + "' style='border-width: 0px;'></td>" +
            "<td>" + blog.createTime + "</td>" +
            "<td>" + blog.updateTime + "</td>" +
            "<td>" + blog.publishTime + "</td>" +
            "<td>" + 10 + "</td>" +
            "<td>" + 10 + "</td>" +
            "<td>" + 10 + "</td>" +
            "<td>" +
            "<a type='button' class='btn btn-primary btn-lg'" +
            "href='edit/" + id + ".do' target='_blank'>编辑</a>" +
            "<button type='button' class='btn btn-primary btn-lg'" +
            "onclick='deleteMode(" + id + ")' " +
            "data-toggle='modal' data-target='#delete-blog-modal'>删除" +
            "</button>" +
            "</tr>";
    }
    table += "</table>";

    $("#blog-table-div").html(table);


    $("#page-next").html(pageNextHtml);
    $("#page-previous").html(pagePreviousHtml);
    if (currentPage == 1 || pages <= 1) {
        $("#page-previous").html("");
    }
    if (currentPage == pages || pages == 0) {
        $("#page-next").html("");
    }
}

function search() {
    searchKey = $("#searchKey").val();
    getBlogByPage(1);
}



function deleteMode(id) {
    var title = $("#title-input-"+id).val();
    var deleteWarning = "您确定删除" + title + "及其有关的文章？";
    $("#delete-warning").html(deleteWarning);
    $("#delete-id").val(id);
}

function deleteSubmit() {
    var id = $("#delete-id").val();
    $("#delete-blog-modal").modal('hide');
    $.ajax({
        type        : "POST",
        url         : "delete/" + id + ".do",
        success     : function(msg) {
                        if (msg > 0) {
                            alert("delete success");
                            if (blogs.length == 1 && currentPage > 1 && currentPage == pages) {
                                getBlogByPage(currentPage - 1);
                            } else if (currentPage != 0) {
                                getBlogByPage(currentPage);
                            }
                        } else {
                            alert("delete failure");
                        }
                    },
        error       : function () {
                        alert("服务器请求失败!");
                    }
    });
}
