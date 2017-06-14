<%--
  Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-3-25
  Time: 下午2:29
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="header.jsp"%>
<div class="row">
    <div class="col-sm-12">
        <h4 class="page-title">IBLOG后台</h4>
    </div>

    <div class="row">
        <div class="col-sm-6 col-lg-3">
            <div class="mini-stat clearfix bx-shadow bg-info">
                <span class="mini-stat-icon"><i class="fa fa-quote-right" aria-hidden="true"></i></span>
                <div class="mini-stat-info text-right">
                    发表了${requestScope.publishCount}篇博客
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-lg-3">
            <div class="mini-stat clearfix bg-purple bx-shadow">
                <span class="mini-stat-icon"><i class="fa fa-comments-o" aria-hidden="true"></i></span>
                <div class="mini-stat-info text-right">
                    收到了${requestScope.commentCount}条评论
                </div>
            </div>
        </div>

        <%--<div class="col-sm-6 col-lg-3">--%>
            <%--<div class="mini-stat clearfix bg-success bx-shadow">--%>
                <%--<span class="mini-stat-icon"><i class="fa fa-cloud-upload" aria-hidden="true"></i></span>--%>
                <%--<div class="mini-stat-info text-right">--%>
                    <%--上传了0个附件--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>

        <div class="col-sm-6 col-lg-3">
            <div class="mini-stat clearfix bg-primary bx-shadow">
                <span class="mini-stat-icon"><i class="fa fa-link" aria-hidden="true"></i></span>
                <div class="mini-stat-info text-right">
                    友链了${requestScope.linkCount}个好友
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
                        <c:choose>
                            <c:when test="${not empty requestScope.recentBlogs}">
                                <c:forEach items="${requestScope.recentBlogs}" var="blog">
                                    <li class="list-group-item">
                                        <span class="badge badge-primary"
                                              title="评论数">${blog.commentTimes}</span>
                                                    <a target="_blank" href="/iblog/blog/${blog.id}.do">${blog.title}</a>
                                    </li>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-warning">
                                    这个人很懒，什么都没有写
                                </div>
                            </c:otherwise>
                        </c:choose>

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
                    <%--<div class="alert alert-warning">--%>
                        <%--还没有收到留言.--%>
                    <%--</div>--%>
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
                        <c:choose>
                            <c:when test="${not empty requestScope.comments}">
                                <c:forEach items="${requestScope.comments}" var="comment">
                                    <li class="list-group-item">
                                            ${comment.comment}
                                    </li>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-warning">
                                    你好像并不受欢迎额，是不是可以把博客写的更好点
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </div>
        <%--<div class="col-md-4">--%>
            <%--<div class="panel panel-default">--%>
                <%--<div class="panel-heading">--%>
                    <%--<h4 class="panel-title">系统日志</h4>--%>
                <%--</div>--%>
                <%--<div class="panel-body">--%>
                    <%--<ul class="list-group">--%>
                        <%--&lt;%&ndash;#for(log : logs)&ndash;%&gt;--%>
                            <%--<span>系统初始化....</span>--%>
                            <%--<span>登陆后台....</span>--%>
                        <%--</li>--%>
                        <%--&lt;%&ndash;#end&ndash;%&gt;--%>
                    <%--</ul>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    </div>
</div>
<%@include file="footer.jsp"%>
</body>
</html>
