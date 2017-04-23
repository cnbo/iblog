var currentPage, pages;
var pageNextHtml = "<button onclick='getCategoryByPage(currentPage+1)'>下一页</button>";
var pagePreviousHtml = "<button onclick='getCategoryByPage(currentPage-1)'>上一页</button>";
var searchKey;
var links;

$(function () {
    $("#add-link-form").submit(function () {
        $.ajax({
            type         : "POST",
            url          : "add.do",
            data         : new FormData($("#add-link-form")[0]),
            success      : function (msg) {
                alert("add success");
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
//                                alert(msg.links.length);
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

    var table = "<table>" +
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
            "<button type='button' class='btn btn-primary btn-lg'" +
            "onclick='modifyMode(" + id + ")' " +
            "data-toggle='modal' data-target='#modify-link-modal'>修改" +
            "</button>" +
            "<button type='button' class='btn btn-primary btn-lg'" +
            "onclick='deleteMode(" + id + ")' " +
            "data-toggle='modal' data-target='#delete-link-modal'>删除" +
            "</button>" +
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
                alert("删除成功");
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
                alert("修改成功");
                $("#friend-name-"+id).val(friendName);
                $("#url-"+id).val(url);
            } else {
                alert("修改失败");
            }
        },
        error       : function () {
            alert("服务器请求失败!");
        }
    });
}

