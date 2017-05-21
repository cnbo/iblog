<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-4-1
  Time: 下午4:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="header.jsp"%>
<style>

    .modal-body{
        padding: 10px 0;
        margin: 5px 0 5px 0;
    }
    .modal-body p#delete-warning{
        margin:0px;
        font-size: 16px;
    }

    #page-next, #page-previous{
        text-align: center;
        /*margin:5px;*/
    }

</style>
    <%--<meta charset="utf-8">--%>
    <%--<title>标签/分类</title>--%>

    <div class="col-sm-3" >
        <div class="input-group">
         <input type="text" id="searchKey" class="form-control" placeholder="搜索类别">
            <span class="input-group-btn">
                <button onclick="search()" class="btn btn-primary">搜索</button>
            </span>
        </div>
    </div>
    <div class="col-sm-12">
        <h4 class="page-title">分类标签管理</h4>
    </div>

    <div id="category-table-div">

    </div>

<div>
    <ul style="list-style: none">
        <li id="page-previous" style="float: left"></li>
        <li id="page-next" style="float: right"></li>
    </ul>
</div>

    <div class="col-md-12" style="margin-top:20px">
        <div class="panel panel-default">
            <div class="panel-body">
                <form id="add-category-form" class="form-inline" role="form">
                    <input type="hidden" id="mid"/>
                    <div class="form-group">
                        <input type="text" class="form-control" name="categoryName" id="categoryName" placeholder="请输入分类名称">
                    </div>
                    <button id="save-category-btn" type="submit"
                            class="btn btn-success waves-effect waves-light m-l-10">保存分类
                    </button>
                </form>
            </div>
        </div>
    </div>



    <!-- 文章类别修改模态框 -->
    <div id="modify-category-modal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h3 class="modal-title">修改类别</h3>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="categoryId" value="" id="modify-id">
                    <label class="col-xs-2 control-label">
                        类别
                    </label>
                    <input type="text" name="categoryName" id="category-input" value="">
                </div>
                <div class="modal-footer" style="padding-top: 10px;">
                    <button type="button" class="btn btn-default" data-dismiss="modal" aria-hidden="true">
                        取消
                    </button>
                    <button type="button" class="btn btn-primary" onclick="modifySubmit()">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <!-- 文章类别删除模态框 -->
    <div id="delete-category-modal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h3 class="modal-title">删除类别</h3>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="categoryId" value="" id="delete-id">
                    <p id="delete-warning"></p>
                </div>
                <div class="modal-footer" style="padding-top: 10px;">
                    <button type="button" class="btn btn-default" data-dismiss="modal" aria-hidden="true">
                        取消
                    </button>
                    <button type="button" class="btn btn-primary" onclick="deleteSubmit()">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

<%@include file="footer.jsp"%>
<%--<script type="application/javascript" src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>--%>
<%--<script type="application/javascript"--%>
        <%--src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>--%>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/js/category-manage.js"></script>

</body>
</html>
