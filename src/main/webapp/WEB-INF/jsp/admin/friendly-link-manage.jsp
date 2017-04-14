<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-4-1
  Time: 下午4:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>友情链接</title>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>
    <script type="application/javascript">
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
                var id = links[index].id;
                table += "<tr>" +
                    "<td>" + id + "</td>" +
                    "<td>" + links[index].friendName + "</td>" +
                    "<td>" + links[index].url + "</td>" +
                    "<td>" + links[index].createTime + "</td>" +
                    "<td>" + links[index].updateTime + "</td>" +
                    "<td><button onclick='deleteLink(" + id + ")'>删除</button> " +
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

        function deleteLink(id) {
            $.ajax({
                type        : "POST",
                url         : "delete/" + id + ".do",
                success     : function (msg) {
                                alert("delete success");
                                if (links.length == 1 && currentPage > 1 && currentPage == pages) {
                                    getCategoryByPage(currentPage - 1);
                                } else if (currentPage != 0) {
                                    getCategoryByPage(currentPage);
                                }
                            }
            });
        }
    </script>
</head>
<body>

    <div>
        <input type="text" id="searchKey">
        <button onclick="search()">搜索</button>
    </div>

    <div id="friendly-link-table-div">

    </div>

    <div id="page-previous">

    </div>
    <div id="page-next">

    </div>

    <h3>添加友链</h3>
    <form id="add-link-form">
        昵称 <input type="text" name="friendName" id="friendName"> <br>
        链接 <input type="url" name="url" id="url"> <br>
        <input type="submit" value="保存">
    </form>
</body>
</html>
