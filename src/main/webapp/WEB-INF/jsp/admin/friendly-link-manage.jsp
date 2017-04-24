<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-4-1
  Time: 下午4:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>友情链接</title>
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.css">
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

    <!-- 友情链接修改模态框 -->
    <div id="modify-link-modal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">修改类别</h4>
                </div>
                <form class="form-horizontal" enctype="multipart/form-data">
                    <div class="modal-body">

                        <input type="hidden" name="linkId" value="" id="modify-id">
                        <div class="form-group">
                            <label class="col-xs-2 control-label">
                                昵称
                            </label>
                            <div class="col-xs-10">
                                <input class="form-control" type="text" name="friendName" id="friend-name" value="">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label">
                                链接
                            </label>
                            <div class="col-xs-10">
                                <input class="form-control" type="text" name="url" id="friend-url" value="">
                            </div>
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" aria-hidden="true">
                        取消
                    </button>
                    <button type="button" class="btn btn-primary" onclick="modifySubmit()">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <!-- 友情链接删除模态框 -->
    <div id="delete-link-modal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">删除友情链接</h4>
                </div>
                <div class="modal-body">
                    <input type="hidden" value="" id="delete-id">
                    <p id="delete-warning"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" aria-hidden="true">
                        取消
                    </button>
                    <button type="button" class="btn btn-primary" onclick="deleteSubmit()">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <table>
        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/admin/blog/write.do">写博客</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/admin/blog/manage.do">博客管理</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/admin/category/manage.do">标签/分类</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/admin/friendly-link/manage.do">友情链接</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="#">用户管理</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="#">评论管理</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/admin/profile.do">个人信息</a>
            </td>
        </tr>
    </table>

    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/js/friend-link-manage.js"></script>
</body>
</html>
