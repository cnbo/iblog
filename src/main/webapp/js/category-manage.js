var currentPage, pages;
var pageNextHtml = "<a type='button' class='btn btn-primary btn-lg' onclick='getCategoryByPage(currentPage+1)'>下一页</a>";
var pagePreviousHtml = "<a type='button' class='btn btn-primary btn-lg' onclick='getCategoryByPage(currentPage-1)'>上一页</a>";
var searchKey;
var categories;
var tale = new $.tale();

$(function () {
    $("#add-category-form").submit(function () {
        $.ajax({
            type          : "POST",
            url           : "add.do",
            data          : new FormData($("#add-category-form")[0]),
            processData   : false,
            contentType   : false,
            success       : function (msg) {
                                tale.alertOk("add success");
                                if (pages == 0) {
                                    getCategoryByPage(1);
                                } else {
                                    getCategoryByPage(currentPage);
                                }
                            },
            error         : function () {
                                tale.alertError("服务器请求失败");
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
                        tale.alertError("服务器请求失败");
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

    var table = "<table class='table table-striped'>" +
        "<thead>" +
        "<tr>" +
        "<th>ID</th>" +
        "<th>分类</th>" +
        "<th>创建时间</th>" +
        "<th>修改时间</th>" +
        "<th>操作</th>" +
        "</tr>" +
        "<thead><tbody>";
    for (var index = 0; index < categories.length; index++) {
        var category = categories[index];
        var id = category.id;
        var categoryName = category.categoryName;
        var createTime = formatDate(category.createTime);
        var updateTime = formatDate(category.updateTime);
        table += "<tr>" +
            "<td>" + id + "</td>" +
            "<td><input id='category-input-" + id + "' value='" +
            categoryName + "' style='border-width: 0px; background: transparent;' readonly='readonly'></td>" +
            "<td>" + createTime + "</td>" +
            "<td>" + updateTime + "</td>" +
            "<td>" +
            "<a type='button' style='margin: 0 5px 0 5px;' class='btn btn-primary btn-sm waves-effect waves-light m-b-5'" +
            "onclick='modifyMode(" + id + ")' " +
            "data-toggle='modal' data-target='#modify-category-modal'><i class='fa fa-edit'></i><span>修改" +
            "</a>" +
            "<a type='button' style='margin: 0 5px 0 5px;' class='btn btn-danger btn-sm waves-effect waves-light m-b-5'" +
            "onclick='deleteMode(" + id + ")' " +
            "data-toggle='modal' data-target='#delete-category-modal'><i class='fa fa-trash-o'></i><span>删除</span>" +
            "</a>" +
            "</td>" +
            "</tr>";
    }
    table += "</tbody></table>";

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
                            tale.alertOk("modify success");
                            $("#category-input" + id).val(categoryName);
                        } else {
                            tale.alertError("modify failure");
                        }
                    },
        error       : function () {
                        tale.alertError("服务器请求失败!");
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
                            tale.alerOkt("delete success");
                            if (categories.length == 1 && currentPage > 1 && currentPage == pages) {
                                getCategoryByPage(currentPage - 1);
                            } else if (currentPage != 0) {
                                getCategoryByPage(currentPage);
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

