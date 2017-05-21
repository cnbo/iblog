<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-4-1
  Time: 下午4:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@include file="header.jsp"%>
<style>

    .modal-body{
        padding: 10px 0 !important;
        margin: 5px 0 5px 0 !important;
    }
    .modal-body p#delete-warning{
        margin:0px;
        font-size: 16px;
    }

    .modal-footer{
        padding-top:10px !important;
    }

    #page-next, #page-previous{
        text-align: center;
        /*margin:5px;*/
    }

</style>


<div class="col-sm-3" >
    <div class="input-group">
        <input type="text" id="searchKey" class="form-control" placeholder="搜索评论">
        <span class="input-group-btn">
                <button onclick="search()" class="btn btn-primary">搜索</button>
            </span>
    </div>
</div>
<div class="col-sm-12">
    <h4 class="page-title">评论管理</h4>
</div>

<div id="comment-table-div">

</div>

<div>
    <ul style="list-style: none">
        <li id="page-previous" style="float: left"></li>
        <li id="page-next" style="float: right"></li>
    </ul>
</div>





<!-- 用户删除模态框 -->
<div id="delete-comment-modal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">删除评论</h4>
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


<%@include file="footer.jsp"%>

<%--<script type="application/javascript" src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>--%>
<%--<script type="application/javascript"--%>
<%--src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>--%>
<script type="application/javascript" src="${pageContext.request.contextPath}/js/comment-manage.js"></script>
</body>
</html>
