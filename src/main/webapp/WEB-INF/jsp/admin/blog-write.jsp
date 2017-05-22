<%--
j Created by IntelliJ IDEA.
  User: cnbo
  Date: 17-4-1
  Time: 下午4:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@include file="header.jsp"%>--%>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
<meta charset="UTF-8">
<title>write blog</title>
<%--Bootstrap css--%>
<%--<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.css">--%>
<%--bootstrap-fileinput css--%>
<link type="text/css" media="all" rel="stylesheet"
      href="${pageContext.request.contextPath}/lib/bootstrap-fileinput/css/fileinput.css">


<link href="//cdn.bootcss.com/select2/3.4.8/select2.min.css" rel="stylesheet"/>
<%--<link href="${pageContext.request.contextPath}/css/select2-bootstrap.css" rel="stylesheet">--%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta content="Coderthemes" name="author"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <link rel="shortcut icon" href="/static/admin/images/favicon.png"/>
    <link href="//cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="//cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.min.css" rel="stylesheet" type="text/css">
    <link href="//cdn.bootcss.com/limonte-sweetalert2/6.4.1/sweetalert2.min.css" rel="stylesheet">
    <link type="text/css" media="all" rel="stylesheet"
          href="${pageContext.request.contextPath}/lib/editor-md/css/editormd.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <style>
        .select2-container{
            border: 1px solid #ccc;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
            -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
        }

        /*.container{*/
        /*width: 90%;*/
        /*}*/

        #blog-editor{
            /*margin-top: 130px;*/
        }
    </style>
</head>
<body class="fixed-left">
<div id="wrapper">
    <div class="topbar">
        <div class="topbar-left">
            <div class="text-center p-t-10" style="margin: 0 auto;">
                <div class="pull-left" style="padding-left: 10px;">
                    <a href="${pageContext.request.contextPath}/admin/index.do">
                        <img src="${pageContext.request.contextPath}/uploads/monkey_logo.jpg" width="50" height="50"/>
                    </a>
                </div>
                <div class="pull-left" style="padding-left: 10px;">
                    <span style="font-size: 28px; color: #2f353f; line-height: 50px;">Iblog</span>
                </div>
            </div>
        </div>
        <div class="navbar navbar-default" role="navigation" style="margin-bottom: 0px">
            <div class="container">
                <div class="">
                    <div class="pull-left">
                        <button type="button" class="button-menu-mobile open-left">
                            <i class="fa fa-bars"></i>
                        </button>
                        <span class="clearfix"></span>
                    </div>

                    <ul class="nav navbar-nav navbar-right pull-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle profile" data-toggle="dropdown"
                               aria-expanded="true"><img src="${pageContext.request.contextPath}/uploads/iblog-admin-user.jpg" alt="user-img" class="img-circle"> </a>
                            <ul class="dropdown-menu">
                                <%--<li><a href="${site_url()}" target="_blank"><i class="fa fa-eye" aria-hidden="true"></i> 查看网站</a></li>--%>
                                <%--<li><a href="/admin/profile"><i class="fa fa-sun-o"></i> 个人设置</a></li>--%>
                                <%--<li><a href="/admin/reload"><i class="fa fa-sun"></i> 重启系统</a></li>--%>
                                <li><a href="/iblog/admin/logout.do"><i class="fa fa-sign-out"></i> 注销</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="left side-menu">
        <div class="sidebar-inner slimscrollleft">
            <div id="sidebar-menu">
                <ul>
                    <%--<li #if(active=='home') class="active" #end>--%>
                    <%--<a href="/admin/index" class="waves-effect #if(active=='home') active #end"><i class="fa fa-dashboard" aria-hidden="true"></i><span> 仪表盘 </span></a>--%>
                    <%--</li>--%>
                    <li #if(active=='publish') class="active" #end>
                        <a href="/iblog/admin/blog/write.do" class="waves-effect #if(active=='publish') active #end"><i class="fa fa-pencil-square-o" aria-hidden="true"></i><span> 写博客 </span></a>
                    </li>
                    <li #if(active=='article') class="active" #end>
                        <a href="/iblog/admin/blog/manage.do" class="waves-effect #if(active=='article') active #end"><i class="fa fa-list" aria-hidden="true"></i><span> 博客管理 </span></a>
                    </li>

                    <%--<li #if(active=='attach') class="active" #end>--%>
                    <%--<a href="/iblog/admin/attach" class="waves-effect #if(active=='attach') active #end"><i class="fa fa-cloud-upload" aria-hidden="true"></i><span> 文件管理 </span></a>--%>
                    <%--</li>--%>
                    <li #if(active=='links') class="active" #end>
                        <a href="/iblog/admin/friendly-link/manage.do" class="waves-effect #if(active=='links') active #end"><i class="fa fa-link" aria-hidden="true"></i><span> 友链管理 </span></a>
                    </li>

                    <li class="has_sub">
                        <a href="javascript:void(0)" class="waves-effect #if(has_sub=='other') active subdrop #end"><i class="fa fa-cubes"></i><span> 其他管理 </span><span class="pull-right"><i class="fa fa-plus"></i></span></a>
                        <ul class="list-unstyled">
                            <li #if(active=="visitor") class="active" #end>
                                <a href="/iblog/admin/visitor/manage.do" class="waves-effect #if(active=='visitor') active #end"><i class="fa fa-user" aria-hidden="true"></i><span> 访客管理 </span></a>
                            </li>
                            <li #if(active=='comments') class="active" #end>
                                <a href="/iblog/admin/comment/manage.do" class="waves-effect #if(active=='comments') active #end"><i class="fa fa-comments" aria-hidden="true"></i><span> 评论管理 </span></a>
                            </li>
                            <li #if(active=='category') class="active" #end>
                                <a href="/iblog/admin/category/manage.do" class="waves-effect #if(active=='category') active #end"><i class="fa fa-tags" aria-hidden="true"></i><span> 分类/标签 </span></a>
                            </li>
                        </ul>
                    </li>

                    <%--<li #if(active=='themes') class="active" #end>--%>
                    <%--<a href="/admin/themes" class="waves-effect #if(active=='themes') active #end"><i class="fa fa-diamond" aria-hidden="true"></i><span> 主题 </span></a>--%>
                    <%--</li>--%>

                    <%--<li #if(active=='setting') class="active" #end>--%>
                    <%--<a href="/admin/setting" class="waves-effect #if(active=='setting') active #end"><i class="fa fa-gear" aria-hidden="true"></i><span> 系统设置 </span></a>--%>
                    <%--</li>--%>

                    <%--#for(item : plugin_menus)--%>
                    <%--<li #if(active==item.slug) class="active" #end>--%>
                    <%--<a href="/admin/plugins/${item.slug}" class="waves-effect #if(active==item.slug) active #end"><i class="${item.icon ?! 'fa fa-gear'}" aria-hidden="true"></i><span> ${item.name} </span></a>--%>
                    <%--</li>--%>
                    <%--#end--%>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="content-page">
        <div class="content">
            <div class="container">

        <c:if test="${requestScope.blog != null}">
            <input type="hidden" id="edit-id" value="${requestScope.blog.id}">
        </c:if>
            <div class="col-sm-12" style="padding: 0px">
                <h4 class="page-title">
                    发布文章
                </h4>
            </div>

        <div class="form-group col-md-6" style="padding: 0 10px 0 0;">
            <input name="title" id="title" type="text" required="true" class="form-control" value="无标题文章" placeholder="请填写文章标签"/>
        </div>

        <div class="form-group col-md-6">
            <select id="category-select">
                <c:if test="${ empty requestScope.blogCategories}">
                    <option value="">java</option>
                </c:if>
                <c:if test="${requestScope.blogCategories != null && requestScope.blog != null}">
                    <c:forEach items="${requestScope.blogCategories}" var="category">
                        <c:if test="${category.id == requestScope.blog.categoryId}">
                            <option value="${category.id}" selected="selected">${category.categoryName}</option>
                        </c:if>
                        <c:if test="${category.id != requestScope.blog.categoryId}">
                            <option value="${category.id}">${category.categoryName}</option>
                        </c:if>
                    </c:forEach>
                </c:if>
                <c:if test="${requestScope.blogCategories != null && requestScope.blog == null}">
                    <c:forEach items="${requestScope.blogCategories}" var="category">
                        <option value="${category.id}">${category.categoryName}</option>
                    </c:forEach>
                </c:if>
            </select>
        </div>

        <%--<input type="text" name="title" id="title" required="true" value="无标题文章"> <br>--%>

        <%--<button id="save-btn" onclick="saveOrUpdateBlog()">保存</button>--%>
        <%--<button id="publish-btn" onclick="updateStatus(1)">发布</button>--%>
        <%--<button id="draft-btn" onclick="updateStatus(1)">存为草稿</button>--%>




        <div id="blog-editor">
                <textarea><c:if test="${requestScope.blog != null}">${requestScope.blog.blogMd}></c:if></textarea>
        </div>

        <div class="text-right" id="blog-editor">
            <button type="button" id="save-btn" class="btn btn-primary waves-effect waves-light" onclick="saveOrUpdateBlog()">
                保存文章
            </button>
            <button type="button" id="publish-btn" class="btn btn-primary waves-effect waves-light" onclick="updateStatus(1)">
                发布文章
            </button>
            <button type="button" class="btn btn-warning waves-effect waves-light" onclick="updateStatus(1)">
                存为草稿
            </button>
        </div>
</div>
</div>
</div>
</div>


<%@include file="footer.jsp"%>

<%--<script type="application/javascript" src="${pageContext.request.contextPath}/lib/jquery/jquery-1.12.4.js"></script>--%>
<script src="//cdn.bootcss.com/select2/3.4.8/select2.min.js"></script>
<%--<script type="application/javascript" src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.js"></script>--%>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/canvas-to-blob.js"></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/sortable.js"></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/purify.js    "></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/fileinput.js"></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/zh.js"></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/lib/editor-md/js/editormd.js"></script>
    <script type="application/javascript">
        var tale = new $.tale();
        var blogEditor, blogId = "", status = 0;
        var updateUrl = "update.do";
        $(document).ready(function () {
            blogEditor = editormd("blog-editor", {
                width               : "100%",
                height              : 540,
                syncScrolling       : "single",
                saveHTMLToTextarea  : true,
                searchReplace : true,
                htmlDecode : "style,script,iframe|on*",
                taskList : true,
                tocm            : true,         // Using [TOCM]
                tex : true,                   // 开启科学公式TeX语言支持，默认关闭
                flowChart : true,             // 开启流程图支持，默认关闭
                sequenceDiagram : true,       // 开启时序/序列图支持，默认关闭,
                imageUpload : true,
                imageFormats : ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
                imageUploadURL : "upload.do",
                toolbarIcons        : function() {
                    return ["undo", "redo", "|",
                        "bold", "del", "italic", "quote", "ucwords", "uppercase", "lowercase", "|",
                        "h1", "h2", "h3", "h4", "h5", "h6", "|",
                        "list-ul", "list-ol", "hr", "|",
                        "link", "reference-link", "image", "code", "preformatted-text",
                        "code-block", "table", "datetime", "html-entities", "pagebreak",  "|",
                        "goto-line", "watch", "preview", "fullscreen", "|",
                        "search", "clear", "help"
                    ]
                },
                path                : "${pageContext.request.contextPath}/lib/editor-md/lib/"
            });


            // about select2
            $("#category-select").select2({
                width: '100%',
                placeholder: "选择分类",
                allowClear: true
            });
        });


        function getJsonData(type) {
            var categoryName = $("#category-select").find("option:selected").text();
            var categoryId = $("#category-select").val();
            var title = $("#title").val();
            var blogMd = blogEditor.getMarkdown();
            var blogHtml = blogEditor.getHTML();

            switch (type) {
                case "save":
                    return JSON.stringify({"categoryId":categoryId,
                        "categoryName":categoryName,
                        "title":title, "blogMd":blogMd, "blogHtml":blogHtml});
                case "update":
                    return JSON.stringify({"categoryId":categoryId,
                        "categoryName":categoryName,
                        "title":title, "blogMd":blogMd, "blogHtml":blogHtml,
                        "id":blogId});
                case "draftOrPublish":
                    return JSON.stringify({"categoryId":categoryId,
                        "categoryName":categoryName,
                        "title":title, "blogMd":blogMd, "blogHtml":blogHtml,
                        "id":blogId,
                        "status":status});
            }
        }

        //每3秒保存一次文章
        setInterval("autoSave()", 3000);

        var preBlogContent = "";
        function autoSave() {
            var nowBlogContent = blogEditor.getMarkdown();
            if (preBlogContent.length == nowBlogContent.length && nowBlogContent == preBlogContent) {
                return;
            }

            saveOrUpdateBlog();
        }

        function saveOrUpdateBlog() {
            var editInput = $("#edit-id");
            if (editInput.length > 0) {
                blogId = editInput.val();
                updateUrl = "../update.do";
            }
            if (blogId == "") {
                saveBlog();
            } else {
                updateBlog(getJsonData("update"));
            }
        }

        function saveBlog() {
            var dataJSON = getJsonData("save");
            $.ajax({
                type         : "POST",
                url          : "save.do",
                dataType     : "json",
                contentType  : "application/json;charset=utf-8",
                data         : dataJSON,
                success      : function (msg) {
                    if (msg > 0) {
                        blogId = msg;
//                        tale.alertOk("save blog success");
                        preBlogContent = blogEditor.getMarkdown();
                    } else {
//                        tale.alertError("save failure");
                    }
                },
                error        : function () {
                    tale.alertError("访问失败");
                }
            });
        }

        function updateBlog(dataJSON) {
            $.ajax({
                type         : "POST",
                url          : updateUrl,
                dataType     : "json",
                contentType  : "application/json;charset=utf-8",
                data         : dataJSON,
                success      : function (msg) {
                    if (msg > 0) {
//                        tale.alertOk("更新内容成功！");
                        preBlogContent = blogEditor.getMarkdown();
                    } else {
//                        tale.alertError("更新内容失败!");
                    }
                },
                error        : function () {
                    tale.alertError("访问服务器失败!");
                }
            });
        }

        function updateStatus(statusVal) {
            status = statusVal;
            updateBlog(getJsonData("draftOrPublish"));
        }


        function showHtml() {
            var html = blogEditor.getHTML();
            $("#show-html-div").html(html);
        }
    </script>
</body>
</html>
