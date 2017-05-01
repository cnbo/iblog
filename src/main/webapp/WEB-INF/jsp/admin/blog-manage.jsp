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

    .modal-footer{
        padding-top:10px;
    }
</style>
    <%--<title>博客管理</title>--%>
    <%--<link type="text/css" rel="stylesheet"--%>
            <%--href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.css">--%>


    <div class="col-sm-3" >
        <div class="input-group">
         <input type="text" id="searchKey" class="form-control" placeholder="搜索文章">
            <span class="input-group-btn">
                <button onclick="search()" class="btn btn-primary">搜索</button>
            </span>
        </div>
    </div>

    <div class="col-sm-12">
        <h4 class="page-title">文章管理</h4>
    </div>

    <div class="col-md-12" id="blog-table-div">

    </div>

    <div id="page-previous">

    </div>
    <div id="page-next">

    </div>


    <!-- 文章类别删除模态框 -->
    <div id="delete-blog-modal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="padding: 20px;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h3 class="modal-title">删除类别</h3>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="blogId" value="" id="delete-id">
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
        src="${pageContext.request.contextPath}/js/blog-manage.js"></script>

</body>
</html>
