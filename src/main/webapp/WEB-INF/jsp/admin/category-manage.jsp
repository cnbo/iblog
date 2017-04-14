<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-4-1
  Time: 下午4:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title>标签/分类</title>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>
    <script type="application/javascript">
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
                var id = categories[index].id;
                table += "<tr onblur='deleteMode(" + id + ")'>" +
                            "<td>" + id + "</td>" +
                            "<td><input id='category-input-" + id + "' value='" +
                            categories[index].categoryName +
                            "' style='border-width: 0px;' onfocus='updateMode(" +
                            id + ")'></td>" +
                            "<td>" + categories[index].createTime + "</td>" +
                            "<td>" + categories[index].updateTime + "</td>" +
                            "<td id='delete-update-" + id +
                            "'><button onclick='deleteCategory(" + id +")'>删除</button>" +
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

        function deleteCategory(id) {
            $.ajax({
                type        : "POST",
                url         : "delete/" + id + ".do",
                success     : function(msg) {
                                alert("delete success");

                                if (categories.length == 1 && currentPage > 1 && currentPage == pages) {
                                    getCategoryByPage(currentPage - 1);
                                } else if (currentPage != 0) {
                                    getCategoryByPage(currentPage);
                                }
                            }
            });
        }

        function updateMode(id) {
            var updateBtn = "<button onclick='updateCategory(" + id + ")'>保存</button>";
            var cancleBtn = "<button onclick='deleteMode(" + id + ")'>取消</button>";
            $("#delete-update-"+id).html(updateBtn + cancleBtn);

//            for (var index = 0; index < categories.length; index++) {
//                if (id == categories[index].id) {
//                    continue;
//                }
//                deleteMode(categories[index].id);
//            }
        }

        function updateCategory(id) {
            var categoryName = $("#category-input-"+id).val();

            $.ajax({
                type        : "POST",
                url         : "update.do",
                success     : function (msg) {
                                alert("update success");
                                deleteMode(id);
                            },
                data        : JSON.stringify({"id":id, "categoryName":categoryName}),
                dataType    : "json",
                contentType : "application/json; charset=utf-8"
            });
        }

        function deleteMode(id) {
            var deleteBtn = "<button onclick='deleteCategory(" + id + ")'>删除</button>";
            $("#delete-update-"+id).html(deleteBtn);
        }

    </script>
</head>
<body>

    <div>
        <input type="text" id="searchKey">
        <button onclick="search()">搜索</button>
    </div>

    <div id="category-table-div">

    </div>

    <div id="page-previous">

    </div>
    <div id="page-next">

    </div>

    <form id="add-category-form">
        分类 <input type="text" name="categoryName" id="categoryName"> <br>
        <input type="submit" value="添加">
    </form>

</body>
</html>
