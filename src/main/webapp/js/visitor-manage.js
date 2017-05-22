var currentPage, pages;
var pageNextHtml = "<a type='button' class='btn btn-primary btn-lg' onclick='getVisitorByPage(currentPage+1)'>下一页</a>";
var pagePreviousHtml = "<a type='button' class='btn btn-primary btn-lg' onclick='getVisitorByPage(currentPage-1)'>上一页</a>";
var searchKey;
var visitorAndCommentCountDTOS;
var tale = new $.tale();

$(function () {
    getVisitorByPage(1);
});


function getVisitorByPage(page) {
    var dataJSON;
    if (searchKey != "" && searchKey != null) {
        dataJSON = JSON.stringify({"page":page, "visitorName":searchKey, "pageCount":6});
    } else {
        dataJSON = JSON.stringify({"page":page, "pageCount":6});
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
    visitorAndCommentCountDTOS = msg.visitorAndCommentCountDTOS;
    pages = msg.pages;
    currentPage = msg.page;

    if(visitorAndCommentCountDTOS.length == 0) return;

    var table = "<table  class='table table-striped'>" +
        "<thead>" +
        "<tr>" +
        "<th>ID</th>" +
        "<th>用户名</th>" +
        "<th>创建时间</th>" +
        "<th>评论数</th>" +
        "<th>操作</th>" +
        "</tr>" +
        "<thead><tbody>";
    for (var index = 0; index < visitorAndCommentCountDTOS.length; index++) {
        var visitor = visitorAndCommentCountDTOS[index].visitor;
        var id = visitor.id;
        var createTime = formatDate(visitor.createTime);
        var commentCount = visitorAndCommentCountDTOS[index].commentCount;
        table += "<tr>" +
            "<td>" + id + "</td>" +
            "<td>" +
            "<input id='visitor-name-" + id + "' value='" + visitor.visitorName + "'" +
            "style='border-width: 0px; background: transparent;' readonly='readonly'>" +
            "</td>" +
            "<td>" + createTime + "</td>" +
            "<td>" + commentCount + "</td>" +
            "<td>" +
            "<a type='button' class='btn btn-danger btn-sm waves-effect waves-light m-b-5'" +
            "onclick='deleteMode(" + id + ")' " +
            "data-toggle='modal' style='margin: 0 5px  0 5px;' data-target='#delete-visitor-modal'><i class='fa fa-trash-o'></i><span>删除</span>" +
            "</a>" +
            "</td>" +
            "</tr>";
    }
    table += "</tbody></table>";

    $("#visitor-table-div").html(table);


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
    getVisitorByPage(1);
}

function deleteMode(id) {
    var visitorName = $("#visitor-name-"+id).val();
    var deleteWarning = "您确定删除" + visitorName + "及其相关评论";
    $("#delete-warning").html(deleteWarning);
    $("#delete-id").val(id);
}

function deleteSubmit() {
    var id = $("#delete-id").val();
    $("#delete-visitor-modal").modal('hide');
    $.ajax({
        type        : "POST",
        url         : "delete/" + id + ".do",
        success     : function (msg) {
            if (msg > 0) {
                tale.alertOk("删除成功");
                if (visitorAndCommentCountDTOS.length == 1 && currentPage > 1 && currentPage == pages) {
                    getVisitorByPage(currentPage - 1);
                } else if (currentPage != 0) {
                    getVisitorByPage(currentPage);
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

