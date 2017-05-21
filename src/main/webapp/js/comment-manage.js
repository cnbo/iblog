var currentPage, pages;
var pageNextHtml = "<a type='button' class='btn btn-primary btn-lg' onclick='getCommentByPage(currentPage+1)'>下一页</a>";
var pagePreviousHtml = "<a type='button' class='btn btn-primary btn-lg' onclick='getCommentByPage(currentPage-1)'>上一页</a>";
var searchKey;
var commentInfoDTOS;
var tale = new $.tale();

$(function () {
    getCommentByPage(1);
});


function getCommentByPage(page) {
    var dataJSON;
    if (searchKey != "" && searchKey != null) {
        dataJSON = JSON.stringify({"page":page, "comment":searchKey, "pageCount":2});
    } else {
        dataJSON = JSON.stringify({"page":page, "pageCount":2});
    }
    $.ajax({
        type        : "POST",
        url         : "page.do",
        success     : function (msg) {
            // alert(msg.links.length);
            refresh(msg);
        },
        data        : dataJSON,
        dataType    : "json",
        contentType : "application/json; charset=utf-8"
    });
}

function refresh(msg) {
    commentInfoDTOS = msg.commentInfoDTOS;
    pages = msg.pages;
    currentPage = msg.page;

    if(commentInfoDTOS.length == 0) return;

    var table = "<table  class='table table-striped'>" +
        "<thead>" +
        "<tr>" +
        "<th>ID</th>" +
        "<th>用户名</th>" +
        "<th>文章标题</th>" +
        "<th>评论内容</th>" +
        "<th>创建时间</th>" +
        "<th>操作</th>" +
        "</tr>" +
        "<thead><tbody>";
    for (var index = 0; index < commentInfoDTOS.length; index++) {
        var comment = commentInfoDTOS[index].comment;
        var id = comment.id;
        var createTime = formatDate(comment.createTime);
        var blog = commentInfoDTOS[index].blog;
        var visitor = commentInfoDTOS[index].visitor;
        var simpleComment = getSimpleComment(comment.comment);
        table += "<tr>" +
            "<td>" + id + "</td>" +
            "<td>" + visitor.visitorName + "</td>" +
            "<td>" + blog.title + "</td>" +
            "<td>" +
            "<input id='manage-comment-" + id + "' value='" + simpleComment + "'" +
            "style='border-width: 0px; background: transparent;' readonly='readonly' " +
            "title='" + comment.comment + "'>" +
            "</td>" +
            "<td>" + createTime + "</td>" +
            "<td>" +
            "<a type='button' class='btn btn-danger btn-sm waves-effect waves-light m-b-5'" +
            "onclick='deleteMode(" + id + ")' " +
            "data-toggle='modal' style='margin: 0 5px  0 5px;' data-target='#delete-comment-modal'><i class='fa fa-trash-o'></i><span>删除</span>" +
            "</a>" +
            "</td>" +
            "</tr>";
    }
    table += "</tbody></table>";

    $("#comment-table-div").html(table);


    $("#page-next").html(pageNextHtml);
    $("#page-previous").html(pagePreviousHtml);
    if (currentPage == 1 || pages <= 1) {
        $("#page-previous").html("");
    }
    if (currentPage == pages || pages == 0) {
        $("#page-next").html("");
    }
}

function getSimpleComment(comment) {
    var simpleComment = comment;
    if (comment.length > 10) {
        simpleComment = comment.substring(0, 10) + "...";
    }

    return simpleComment;
}

function search() {
    searchKey = $("#searchKey").val();
    getVisitorByPage(1);
}

function deleteMode(id) {
    var deleteWarning = "您确定删除此条评论及其相关评论?";
    $("#delete-warning").html(deleteWarning);
    $("#delete-id").val(id);
}

function deleteSubmit() {
    var id = $("#delete-id").val();
    $("#delete-comment-modal").modal('hide');
    $.ajax({
        type        : "POST",
        url         : "delete/" + id + ".do",
        success     : function (msg) {
            if (msg > 0) {
                tale.alertOk("删除成功");
                if (commentInfoDTOS.length == 1 && currentPage > 1 && currentPage == pages) {
                    getCommentByPage(currentPage - 1);
                } else if (currentPage != 0) {
                    getCommentByPage(currentPage);
                }
            } else {
                tale.alertError("删除失败");
            }
        },
        error      : function () {
            tale.alertError("请求失败")
        }
    });
}


function formatDate(createTime) {
    var date = new Date(createTime);
    var year = date.getFullYear();
    var month = date.getMonth();
    var day = date.getDay();
    var hour = date.getHours();
    var minute = date.getMinutes();

    month = month < 10 ? ("0" + month) : month;
    day = day < 10 ? ("0" + day) : day;
    hour = hour < 10 ? ("0" + hour) : hour;
    minute = minute < 10 ? ("0" + minute) : minute;

    createTime = year + "-" + month + "-" + day + " " + hour + ":" + minute;
    return createTime;
}

