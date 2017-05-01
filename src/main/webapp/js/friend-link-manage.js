var currentPage, pages;
var pageNextHtml = "<a type='button' class='btn btn-primary btn-lg' onclick='getCategoryByPage(currentPage+1)'>下一页</a>";
var pagePreviousHtml = "<a type='button' class='btn btn-primary btn-lg' onclick='getCategoryByPage(currentPage-1)'>上一页</a>";
var searchKey;
var links;
var tale = new $.tale();

$(function () {
    $("#add-link-form").submit(function () {
        $.ajax({
            type         : "POST",
            url          : "add.do",
            data         : new FormData($("#add-link-form")[0]),
            success      : function (msg) {
                tale.alert("add success");
                if (pages == 0) {
                    getCategoryByPage(1);
                } else {
                    getCategoryByPage(currentPage);
                }
            },
            processData  : false,
            contentType  : false
        });

        return false;
    });

    getCategoryByPage(1);
});


function getCategoryByPage(page) {
    var dataJSON;
    if (searchKey != "" && searchKey != null) {
        dataJSON = JSON.stringify({"page":page, "friendName":searchKey, "url":searchKey, "pageCount":2});
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
    links = msg.links;
    pages = msg.pages;
    currentPage = msg.page;

    if(links.length == 0) return;

    var table = "<table  class='table table-striped'>" +
        "<thead>" +
        "<tr>" +
        "<th>ID</th>" +
        "<th>名称</th>" +
        "<th>URL</th>" +
        "<th>创建时间</th>" +
        "<th>修改时间</th>" +
        "<th>操作</th>" +
        "</tr>" +
        "<thead>";
    for (var index = 0; index < links.length; index++) {
        var link = links[index];
        var id = link.id;
        table += "<tr>" +
            "<td>" + id + "</td>" +
            "<td>" +
            "<input id='friend-name-" + id + "' value='" + link.friendName + "'" +
            "style='border-width: 0px;'>" +
            "</td>" +
            "<td>" +
            "<input id='url-" + id + "' value='" + link.url + "'" +
            "style='border-width: 0px;'>" +
            "</td>" +
            "<td>" + link.createTime + "</td>" +
            "<td>" + link.updateTime + "</td>" +
            "<td>" +
            "<a type='button' class='btn btn-primary btn-sm waves-effect waves-light m-b-5'" +
            "onclick='modifyMode(" + id + ")' " +
            "data-toggle='modal' data-target='#modify-link-modal'><i class='fa fa-edit'></i><span>修改`</span>" +
            "</a>" +
            "<a type='button' class='btn btn-danger btn-sm waves-effect waves-light m-b-5'" +
            "onclick='deleteMode(" + id + ")' " +
            "data-toggle='modal' data-target='#delete-link-modal'><i class='fa fa-trash-o'></i><span>删除</span>" +
            "</a>" +
            "</td>" +
            "</tr>";
    }
    table += "</table>";

    $("#friendly-link-table-div").html(table);


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
    getCategoryByPage(1);
}

function deleteMode(id) {
    var friendName = $("#friend-name-"+id).val();
    var deleteWarning = "您确定删除" + friendName + "的友情链接";
    $("#delete-warning").html(deleteWarning);
    $("#delete-id").val(id);
}

function deleteSubmit() {
    var id = $("#delete-id").val();
    $("#delete-link-modal").modal('hide');
    $.ajax({
        type        : "POST",
        url         : "delete/" + id + ".do",
        success     : function (msg) {
            if (msg > 0) {
                tale.alert("删除成功");
                if (links.length == 1 && currentPage > 1 && currentPage == pages) {
                    getCategoryByPage(currentPage - 1);
                } else if (currentPage != 0) {
                    getCategoryByPage(currentPage);
                }
            } else {
                alert("删除失败");
            }
        },
        error      : function () {
            alert("请求失败")
        }
    });
}

function modifyMode(id) {
    var friendName = $("#friend-name-"+id).val();
    var url = $("#url-"+id).val();
    $("#friend-name").val(friendName);
    $("#friend-url").val(url);
    $("#modify-id").val(id);
}

function modifySubmit() {
    var friendName = $("#friend-name").val();
    var url = $("#friend-url").val();
    var id = $("#modify-id").val();
    $("#modify-link-modal").modal('hide');
    $.ajax({
        type        : "POST",
        url         : "update.do",
        data        : JSON.stringify({"id":id, "friendName":friendName, "url":url}),
        dataType    : "json",
        contentType : "application/json; charset=utf-8",
        success     : function (msg) {
            if (msg > 0) {
                tale.alert("修改成功");
                $("#friend-name-"+id).val(friendName);
                $("#url-"+id).val(url);
            } else {
                tale.alertError("修改失败");
            }
        },
        error       : function () {
            tale.alertError("服务器请求失败!");
        }
    });
}

