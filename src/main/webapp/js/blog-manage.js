var currentPage, pages;
var pageNextHtml = "<a type='button' class='btn btn-primary btn-lg' onclick='getBlogByPage(currentPage+1)'>下一页</a>";
var pagePreviousHtml = "<a type='button' class='btn btn-primary btn-lg' onclick='getBlogByPage(currentPage-1)'>上一页</a>";
var searchKey;
var blogs;
var tale = new $.tale();

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
                        tale.alertError("服务器请求失败");
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

    if(blogs.length == 0) return;

    var table = "<table class='table table-striped'>" + "<thead>" +
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
            "<a type='button' class='btn btn-primary btn-sm waves-effect waves-light m-b-5'" +
            "href='edit/" + id + ".do' target='_blank' style='margin-left: 3px;margin-right: 3px;width:5rem;'><i class='fa fa-edit'></i><span>编辑</span></a>" +
            "<a type='button' class='btn btn-danger btn-sm waves-effect waves-light m-b-5'" +
            "onclick='deleteMode(" + id + ")' " +
            "data-toggle='modal' data-target='#delete-blog-modal' style='margin-left: 3px;margin-right: 3px; width: 5em';><i class='fa fa-trash-o'></i><span>删除</span>" +
            "</a>" +
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
    console.log('search!')
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
                            tale.alert("delete success");
                            if (blogs.length == 1 && currentPage > 1 && currentPage == pages) {
                                getBlogByPage(currentPage - 1);
                            } else if (currentPage != 0) {
                                getBlogByPage(currentPage);
                            }
                        } else {
                            tale.alertError("delete failure");
                        }
                    },
        error       : function () {
                        tale.alertError("服务器请求失败!");
                    }
    });
}
