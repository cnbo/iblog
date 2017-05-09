<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-3-25
  Time: 下午2:29
  To change this template use File | Settings | File Templates.
--%>

<%@include file="header.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="row">
    <div class="col-sm-12">
        <h4 class="page-title">IBLOG后台</h4>
    </div>

    <div class="row">
        <div class="col-sm-6 col-lg-3">
            <div class="mini-stat clearfix bx-shadow bg-info">
                <span class="mini-stat-icon"><i class="fa fa-quote-right" aria-hidden="true"></i></span>
                <div class="mini-stat-info text-right">
                    发表了3篇文章
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-lg-3">
            <div class="mini-stat clearfix bg-purple bx-shadow">
                <span class="mini-stat-icon"><i class="fa fa-comments-o" aria-hidden="true"></i></span>
                <div class="mini-stat-info text-right">
                    收到了3条留言
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-lg-3">
            <div class="mini-stat clearfix bg-success bx-shadow">
                <span class="mini-stat-icon"><i class="fa fa-cloud-upload" aria-hidden="true"></i></span>
                <div class="mini-stat-info text-right">
                    上传了0个附件
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-lg-3">
            <div class="mini-stat clearfix bg-primary bx-shadow">
                <span class="mini-stat-icon"><i class="fa fa-link" aria-hidden="true"></i></span>
                <div class="mini-stat-info text-right">
                    友链了1个好友
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">最新文章</h4>
                </div>
                <div class="panel-body">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <span class="badge badge-primary"
                                  title="3条评论">3</span>
                            <a target="_blank" href="">无标题文章</a>
                        </li>
                        <li class="list-group-item">
                            <span class="badge badge-primary"
                                  title="0条评论">0</span>
                            <a target="_blank" href="">文章</a>
                        </li>
                        <li class="list-group-item">
                            <span class="badge badge-primary"
                                  title="0条评论">0</span>
                            <a target="_blank" href="">啦啦啦啦</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">最新留言</h4>
                </div>
                <div class="panel-body">
                    <%--#if(null == comments || comments.size() == 0)--%>
                    <div class="alert alert-warning">
                        还没有收到留言.
                    </div>
                    <%--#else--%>
                    <ul class="list-group">
                        <%--#for(comment : comments)--%>
                        <%--<li class="list-group-item">--%>
                            <%--#if(null != comment.url && comment.url != '')--%>
                            <%--<a href="${comment.url}" target="_blank">${comment.author}</a>--%>
                            <%--#else--%>
                            <%--${comment.author}--%>
                            <%--#end--%>
                            <%--于${fmtdate(comment.created,'MM月dd日HH:mm')} ：<a href="${site_url('/article/')}${comment.cid}#comments" target="_blank">${article(comment.content)}</a>--%>
                        <%--</li>--%>
                        <%--#end--%>
                    </ul>
                    <%--#end--%>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">系统日志</h4>
                </div>
                <div class="panel-body">
                    <ul class="list-group">
                        <%--#for(log : logs)--%>
                            <span>系统初始化....</span>
                            <span>登陆后台....</span>
                        </li>
                        <%--#end--%>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
</body>
</html>
