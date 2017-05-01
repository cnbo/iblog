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
    <title>友情链接</title>

    <div class="col-sm-3" >
        <div class="input-group">
         <input type="text" id="searchKey" class="form-control" placeholder="搜索友链">
            <span class="input-group-btn">
                <button onclick="search()" class="btn btn-primary">搜索</button>
            </span>
        </div>
    </div>
    <div class="col-sm-12">
        <h4 class="page-title">友链管理</h4>
    </div>

    <div id="friendly-link-table-div">

    </div>

    <div id="page-previous">

    </div>
    <div id="page-next">

    </div>


<div class="col-md-12">
    <div class="panel panel-primary">
        <div class="panel-heading"><h3 class="panel-title">保存友链</h3></div>
        <div class="panel-body">

            <form id="add-link-form" class="form-inline" role="form" novalidate="novalidate">

                <input type="hidden" id="mid" name="mid"/>

                <div class="form-group">
                    <label class="sr-only">链接标题</label>
                    <input type="text"  class="form-control" name="friendName" id="friendName" placeholder="请输入链接名称"
                           required aria-required="true"/>
                </div>

                <div class="form-group">
                    <label class="sr-only">链接URL</label>
                    <input type="url" id="url" name="url" class="form-control" placeholder="请输入链接地址" required
                           aria-required="true"/>
                </div>


                <button type="submit" class="btn btn-success waves-effect waves-light m-l-10">保存链接</button>
            </form>
        </div> <!-- panel-body -->
    </div> <!-- panel -->
</div>


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


<%@include file="footer.jsp"%>

    <%--<script type="application/javascript" src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>--%>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>
    <script type="application/javascript" src="${pageContext.request.contextPath}/js/friend-link-manage.js"></script>
</body>
</html>
