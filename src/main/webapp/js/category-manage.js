var currentPage, pages;
var pageNextHtml = "<button onclick='getCategoryByPage(currentPage+1)'>下一页</button>";
var pagePreviousHtml = "<button onclick='getCategoryByPage(currentPage-1)'>上一页</button>";
var searchKey;
var categories;

$(function () {
    $("#add-category-form").submit(function () {
        $.ajax({
            type          : "POST",
            url           : "add.do",
            data          : new FormData($("#add-category-form")[0]),
            processData   : false,
            contentType   : false,
            success       : function (msg) {
                                alert("add success");
                                if (pages == 0) {
                                    getCategoryByPage(1);
                                } else {
                                    getCategoryByPage(currentPage);
                                }
                            },
            error         : function () {
                                alert("服务器请求失败");
                            }
        });

        return false;
    });

    getCategoryByPage(1);

});
function getCategoryByPage(page) {
    var dataJSON;
    if (searchKey != "" && searchKey != null) {
        dataJSON = JSON.stringify({"page":page, "categoryName":searchKey});
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
    categories = msg.categories;
    pages = msg.pages;
    currentPage = msg.page;

    var table = "<table>" +
        "<thead>" +
        "<tr>" +
        "<th>ID</th>" +
        "<th>分类</th>" +
        "<th>创建时间</th>" +
        "<th>修改时间</th>" +
        "<th>操作</th>" +
        "</tr>" +
        "<thead>";
    for (var index = 0; index < categories.length; index++) {
        var category = categories[index];
        var id = category.id;
        var categoryName = category.categoryName;
        table += "<tr>" +
            "<td>" + id + "</td>" +
            "<td><input id='category-input-" + id + "' value='" +
            categoryName + "' style='border-width: 0px;'></td>" +
            "<td>" + category.createTime + "</td>" +
            "<td>" + category.updateTime + "</td>" +
            "<td>" +
            "<button type='button' class='btn btn-primary btn-lg'" +
            "onclick='modifyMode(" + id + ")' " +
            "data-toggle='modal' data-target='#modify-category-modal'>修改" +
            "</button>" +
            "<button type='button' class='btn btn-primary btn-lg'" +
            "onclick='deleteMode(" + id + ")' " +
            "data-toggle='modal' data-target='#delete-category-modal'>删除" +
            "</button>" +
            "</td>" +
            "</tr>";
    }
    table += "</table>";

    $("#category-table-div").html(table);


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

function modifyMode(id) {
    var categoryName = $("#category-input-"+id).val();
    $("#category-input").val(categoryName);
    $("#modify-id").val(id);
}

function modifySubmit() {
    var categoryName = $("#category-input").val();
    var id = $("#modify-id").val();
    $("#modify-category-modal").modal('hide');
    $.ajax({
        type        : "POST",
        url         : "update.do",
        success     : function (msg) {
                        if (msg > 0) {
                            alert("modify success");
                            $("#category-input" + id).val(categoryName);
                        } else {
                            alert("modify failure");
                        }
                    },
        error       : function () {
                        alert("服务器请求失败!");
                    },
        data        : JSON.stringify({"id":id, "categoryName":categoryName}),
        dataType    : "json",
        contentType : "application/json; charset=utf-8"
    });
}

function deleteMode(id) {
    var categoryName = $("#category-input-"+id).val();
    var deleteWarning = "您确定删除" + categoryName + "及其有关的文章？";
    $("#delete-warning").html(deleteWarning);
    $("#delete-id").val(id);
}

function deleteSubmit() {
    var id = $("#delete-id").val();
    $("#delete-category-modal").modal('hide');
    $.ajax({
        type        : "POST",
        url         : "delete/" + id + ".do",
        success     : function(msg) {
                        if (msg > 0) {
                            alert("delete success");
                            if (categories.length == 1 && currentPage > 1 && currentPage == pages) {
                                getCategoryByPage(currentPage - 1);
                            } else if (currentPage != 0) {
                                getCategoryByPage(currentPage);
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

